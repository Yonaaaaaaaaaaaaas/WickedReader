"""Generates the synthetic test files. Real-world samples (scanned PDF, RTL, fixed-layout EPUB) must be added by hand
from public-domain sources (Project Gutenberg, Standard Ebooks) and listed in manifest.csv.
Usage: python make_testlib.py"""
import os, zipfile, shutil
out = os.path.join(os.path.dirname(__file__), "files"); os.makedirs(out, exist_ok=True)
def w(name, data, mode="wb"):
    with open(os.path.join(out, name), mode) as f: f.write(data)
w("not-a-pdf.pdf", "this is plain text\n", "w")
with zipfile.ZipFile(os.path.join(out, "not-an-epub.epub"), "w") as z: z.writestr("readme.txt", "no mimetype entry")
w("pdf-corrupt.pdf", b"%PDF-1.7\n1 0 obj\n<< /Type /Catalog")
with open(os.path.join(out, "oversize.pdf"), "wb") as f:   # sparse 501 MB, begins with a PDF header
    f.write(b"%PDF-1.7\n"); f.seek(501*1024*1024); f.write(b"\0")
with zipfile.ZipFile(os.path.join(out, "epub-malicious.epub"), "w") as z:
    z.writestr("mimetype", "application/epub+zip", compress_type=zipfile.ZIP_STORED)
    z.writestr("META-INF/container.xml", '<?xml version="1.0"?><container version="1.0" xmlns="urn:oasis:names:tc:opendocument:xmlns:container"><rootfiles><rootfile full-path="OEBPS/content.opf" media-type="application/oebps-package+xml"/></rootfiles></container>')
    z.writestr("OEBPS/content.opf", '<?xml version="1.0"?><package xmlns="http://www.idpf.org/2007/opf" version="3.0" unique-identifier="id"><metadata xmlns:dc="http://purl.org/dc/elements/1.1/"><dc:identifier id="id">urn:test:evil</dc:identifier><dc:title>Script Test</dc:title><dc:language>en</dc:language></metadata><manifest><item id="c1" href="c1.xhtml" media-type="application/xhtml+xml"/></manifest><spine><itemref idref="c1"/></spine></package>')
    z.writestr("OEBPS/c1.xhtml", '<html xmlns="http://www.w3.org/1999/xhtml"><body><p>Hello</p><script>document.title="PWNED"</script><img src="http://example.invalid/track.png"/></body></html>')
print("written to", out)
