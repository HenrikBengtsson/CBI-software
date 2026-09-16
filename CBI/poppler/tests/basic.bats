setup() {
    load "${BATS_SUPPORT_HOME:?}/load.bash"
    load "${BATS_ASSERT_HOME:?}/load.bash"
    load "${BATS_FILE_HOME:?}/load.bash"
}

## A minimal, hand-written PDF that draws the text 'CBI' using one of the
## base-14 fonts, i.e. it needs no embedded font and no external font file.
## It deliberately has no xref table; poppler reconstructs one, which every
## version since 0.x does.
make_pdf() {
    cat > "${1:?}" <<'EOF'
%PDF-1.4
1 0 obj
<< /Type /Catalog /Pages 2 0 R >>
endobj
2 0 obj
<< /Type /Pages /Kids [3 0 R] /Count 1 >>
endobj
3 0 obj
<< /Type /Page /Parent 2 0 R /MediaBox [0 0 200 200] /Contents 4 0 R /Resources << /Font << /F1 5 0 R >> >> >>
endobj
4 0 obj
<< /Length 35 >>
stream
BT /F1 24 Tf 20 100 Td (CBI) Tj ET
endstream
endobj
5 0 obj
<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica >>
endobj
trailer
<< /Size 6 /Root 1 0 R >>
%%EOF
EOF
}


## A PDF whose only text is U+3042 HIRAGANA LETTER A, written as the two-byte
## code <3042> under the /UniJIS-UCS2-H encoding of a CID-keyed font.  Mapping
## that back to Unicode needs BOTH 'cMap/Adobe-Japan1/UniJIS-UCS2-H' and
## 'cidToUnicode/Adobe-Japan1' from the encoding tables; poppler ships no
## resident fallback for either, so extraction fails without them.  No font is
## embedded -- only the character-code mapping is under test, not glyphs.
make_cjk_pdf() {
    cat > "${1:?}" <<'EOF'
%PDF-1.4
1 0 obj
<< /Type /Catalog /Pages 2 0 R >>
endobj
2 0 obj
<< /Type /Pages /Kids [3 0 R] /Count 1 >>
endobj
3 0 obj
<< /Type /Page /Parent 2 0 R /MediaBox [0 0 200 200] /Contents 4 0 R /Resources << /Font << /F1 5 0 R >> >> >>
endobj
4 0 obj
<< /Length 37 >>
stream
BT /F1 24 Tf 20 100 Td <3042> Tj ET
endstream
endobj
5 0 obj
<< /Type /Font /Subtype /Type0 /BaseFont /KozMinPr6N-Regular /Encoding /UniJIS-UCS2-H /DescendantFonts [6 0 R] >>
endobj
6 0 obj
<< /Type /Font /Subtype /CIDFontType0 /BaseFont /KozMinPr6N-Regular /CIDSystemInfo << /Registry (Adobe) /Ordering (Japan1) /Supplement 6 >> /FontDescriptor 7 0 R >>
endobj
7 0 obj
<< /Type /FontDescriptor /FontName /KozMinPr6N-Regular /Flags 4 /FontBBox [0 -120 1000 880] /ItalicAngle 0 /Ascent 880 /Descent -120 /CapHeight 700 /StemV 80 >>
endobj
trailer
<< /Size 8 /Root 1 0 R >>
%%EOF
EOF
}


## -----------------------------------------------------------------
## poppler-utils half
## -----------------------------------------------------------------
@test "pdftotext is installed and reports this version" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run pdftotext -v
    assert_success
    assert_output --partial "${MODULE_VERSION}"
}

@test "pdftotext on PATH is the one from THIS module" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run command -v pdftotext
    assert_success
    assert_output "${PREFIX:?}/bin/pdftotext"
}

@test "pdftotext extracts text from a PDF" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"

    cd "${BATS_TEST_TMPDIR:?}"
    make_pdf cbi.pdf
    run pdftotext cbi.pdf -
    assert_success
    assert_output --partial "CBI"
}


## -----------------------------------------------------------------
## poppler-cpp-devel half
## -----------------------------------------------------------------
@test "shared libraries are installed" {
    run stat "${PREFIX:?}/lib/libpoppler.so"
    assert_success
    run stat "${PREFIX:?}/lib/libpoppler-cpp.so"
    assert_success
}

@test "C++ headers are installed" {
    run stat "${PREFIX:?}/include/poppler/cpp/poppler-document.h"
    assert_success
    run stat "${PREFIX:?}/include/poppler/cpp/poppler-version.h"
    assert_success
}

@test "pkg-config resolves poppler-cpp to THIS module" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run pkg-config --exists poppler-cpp
    assert_success
    prefix=$(pkg-config --variable=prefix poppler-cpp)
    assert_equal "${prefix}" "${PREFIX}"
}

## 'poppler-cpp.pc' has 'Requires.private: poppler', and 'poppler.pc' in turn
## names freetype2, fontconfig, zlib, libjpeg, libpng and libtiff-4.
## pkg-config resolves that whole chain or nothing, so one missing system
## *.pc file breaks every consumer -- including the 'pdftools' R package,
## whose configure script runs exactly this -- while the test above still
## passes.
@test "pkg-config resolves the full Requires.private: chain" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"
    run pkg-config --print-errors --cflags --libs poppler-cpp
    assert_success
    assert_output --partial "-lpoppler-cpp"
}


## -----------------------------------------------------------------
## Encoding tables (the separately licensed 'poppler-data')
## -----------------------------------------------------------------
## POPPLER_DATADIR is where libpoppler looks for the encoding tables when the
## caller sets no data directory of its own, which is the case for 'pdftools'.
## This module points it at the distribution's copy rather than bundling the
## tables.
##
## The value cannot be read back from outside: it is compiled into libpoppler
## and 'GlobalParams.cc' offers no environment-variable override.  Inspecting
## the binary does not work either -- GCC materialises the literal as immediate
## stores rather than placing it in .rodata, so 'strings' never sees it, and an
## absence check against it passes vacuously.  So test the behaviour instead.
POPPLER_DATADIR=/usr/share/poppler

## Optional at run time: poppler degrades quietly when the tables are absent,
## so this reports rather than fails.  A skip here means CJK and Cyrillic PDFs
## will not extract correctly and the 'poppler-data' rpm is worth asking for.
@test "encoding tables are present on this host" {
    [[ -d "${POPPLER_DATADIR}" ]] || skip "not installed: ${POPPLER_DATADIR} (rpm: poppler-data)"
    run stat "${POPPLER_DATADIR}/cMap/Adobe-Japan1/UniJIS-UCS2-H"
    assert_success
}

## If the test above passes and this one fails, the tables are on the host but
## libpoppler was built pointing somewhere else.  Compared as hex rather than
## as characters: poppler emits UTF-8 whatever the locale, so 'e38182'
## (U+3042) is a fixed expectation, while a literal would depend on LANG.
@test "libpoppler was built to find those tables" {
    [[ -d "${POPPLER_DATADIR}" ]] || skip "not installed: ${POPPLER_DATADIR} (rpm: poppler-data)"
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"

    cd "${BATS_TEST_TMPDIR:?}"
    make_cjk_pdf cjk.pdf
    run bash -c "pdftotext cjk.pdf - | od -An -tx1 | tr -d ' \n'"
    assert_success
    assert_output --partial "e38182"
}


## -----------------------------------------------------------------
## All of it together -- what an R package such as 'pdftools' does:
## compile and link against poppler-cpp using the flags pkg-config hands
## out, then open a PDF and pull the text out of it.
## -----------------------------------------------------------------
@test "a poppler-cpp program compiles, links and runs" {
    module load "${MODULE_REPO}" "${MODULE_NAME}/${MODULE_VERSION}"

    cd "${BATS_TEST_TMPDIR:?}"
    make_pdf cbi.pdf

    cat > main.cpp <<'EOF'
#include <iostream>
#include <memory>
#include <poppler-document.h>
#include <poppler-page.h>

int main() {
  std::unique_ptr<poppler::document> doc(poppler::document::load_from_file("cbi.pdf"));
  if (!doc) return 1;
  if (doc->pages() != 1) return 2;
  std::unique_ptr<poppler::page> page(doc->create_page(0));
  if (!page) return 3;
  std::cout << page->text().to_latin1() << std::endl;
  return 0;
}
EOF

    run bash -c '${CXX:-g++} -std=c++17 -o smoke main.cpp $(pkg-config --cflags --libs poppler-cpp)'
    assert_success

    run ./smoke
    assert_success
    assert_output --partial "CBI"
}
