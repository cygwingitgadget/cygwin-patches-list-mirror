From: Charles Wilson <cwilson@ece.gatech.edu>
To: cygwin-patches@sources.redhat.com
Subject: [patch] partial /dev/clipboard support for cygwin
Date: Thu, 12 Oct 2000 22:54:00 -0000
Message-id: <39E6A45B.100411BB@ece.gatech.edu>
X-SW-Source: 2000-q4/msg00002.html
Content-type: multipart/mixed; boundary="----------=_1583532846-65437-14"

This is a multi-part message in MIME format...

------------=_1583532846-65437-14
Content-length: 2122

(my apologies if this is a duplicate message; I'm having trouble with my
mail server)

This patch provides limited /dev/clipboard capability for cygwin.  The
limitations are:

1) read-only

2) /dev/clipboard can only be read all-at-once -- no buffering.  It
should be possible to provide seek() capability so that the contents of
the clipboard can be read in multiple small chunks, but thread safety is
an issue.  I felt it best to get the initial support into cygwin, and
then try to add seek() support and buffering. 

Note that since /bin/cat uses a small buffer (1024 bytes), "cat
/dev/clipboard" only works reliably if the contents of the clipboard is
smaller than 1024.  The following snippet of code can be used to
demonstrate that, with a large enough buffer, "read the whole thing at
once" *does* work.  Just change 'BUFSZ' to a value larger than the
clipboard contents.  (For testing purposes, I found the "putclip"
program useful -- so I could "put" a file of known size into the windows
clipboard.  You can get putclip from
http://cygutils.netpedia.net/misc.tar.gz )

----clip-----
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>

#define BUFSZ 72000

int main(int argc, char * argv[])
{
	char buf[BUFSZ+1];
	int fd;
	fd = open("/dev/clipboard", O_BINARY | O_RDONLY );
	read(fd, buf, BUFSZ);
	buf[BUFSZ] = '\0';
	printf("%s", buf);
}
------clip-----

--Chuck

2000-10-13  Charles Wilson  <cwilson@ece.gatech.edu>

	* winsup/cygwin/Makefile.in: add libuser32.a to the list of
DLL_IMPORTS,
	and include fhandler_clipboard.o in the list of DLL_OFILES
	* winsup/cygwin/dtable.cc (dtable::build_fhander): check for
FH_CLIPBOARD
	* winsup/cygwin/fhandler.h: add fhandler_dev_clipboard to comments, add
	FH_CLIPBOARD to fhandler enum
	* winsup/cygwin/fhandler.h (fhandler_dev_clipboard): new declaration
	* winsup/cygwin/path.cc (windows_device_names): add "\\dev\\clipboard"
	* winsup/cygwin/path.cc (get_device_number): check for FH_CLIPBOARD
	* winsup/cygwin/winsup.h: add a few more #defines from winuser.h
	* winsup/cygwin/fhandler_clipboard.cc: new file
fhandler_clipboard.cc.gz
clipboard.patch6a.gz


------------=_1583532846-65437-14
Content-Type: application/x-gzip; charset=binary; name="clipboard.patch6a.gz"
Content-Disposition: inline; filename="clipboard.patch6a.gz"
Content-Transfer-Encoding: base64
Content-Length: 2363

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

------------=_1583532846-65437-14
Content-Type: application/x-gzip; charset=binary;
 name="fhandler_clipboard.cc.gz"
Content-Disposition: inline; filename="fhandler_clipboard.cc.gz"
Content-Transfer-Encoding: base64
Content-Length: 1066

H4sICHsc3TkAA2ZoYW5kbGVyX2NsaXBib2FyZC5jYwCFVd9v2jAQfvdfccs0
KVQU2B5LN42mtCAhqChbt6fIJBcS1bUj2xSxqv/7zk74kW2sfkjiu/N33913
SbpnkOVcpgJ1nOJznIiiXCqu0wtIVIpgFfAkQWOgS+7u3s0YAESq3OpilVv4
1Ov1YI4pjLj1rgddWIsSlluIcq4FGngohFESwmTjH75igp0Vt5jkHUzXLcYW
eWEgKwQC3UuuLagMou1qU8hO7TUqsxuufQQnhnV+SrxR+hFEkaA0tFvLFDXY
nApA/WQcEG1YBbYL6wDcCeQGCUiatbD+gCcQRD9vH8bTeDKOhtP7YQCZ0ixF
y4l6B866jL0vZCLW1KGAEM267OTBwXZpbFqoTv7lyIRay6YpSLar2np0Ntjp
0USkLKnaGAfAjOW2SOBqNpvAXpEYVdaHbhemswUsRvPh4Pr8fnAzZOyEwBf/
tpNA1A0LCckGZ5I/YYsEvTiMydJ1LLwZxdFkfHc1G8yv21CFvVCgQRsnSwhN
8YsIwZkl2Vp9cjSIwmfIuDDYZ6+MFdKe5KhKlE1GbaB4yARfmTY80YzG9pDZ
myH0t/9lBdBo11rCxzcZbGiScUfhWRWpo+Cqiy0IlFXuGo32b+Jp5NTjCqi0
+m+s0e1kdjWYQL4SS8d0cne/mIMojdVu66qndPToNhmE7xo1OrEAXvwVYEbt
i3busOdb4pbDpm7cot17r7nlYXQTL4Y/Fvs4n5UCQ0+iBbdCLbmYqOQxdBD7
OMeDCoBLqHUP/clWq/YfGLnllPKDD+FwPP0+mOxx3KpyfJOCskAzjVuRUAaj
w7Q2nLUO5x8PxlfG9j6qxMhSUwuzMKzGqQVeBCLfhuCDCdpVzXvUYzZNMk0i
Bx5H1R0a/uccWr3GPmuQrkT1jAGQxrShZB3U24VQWSrL4tNzRgBI/fNB9P3L
iFb16mxylAk25rb35tQmrthqbKuTb71YFaSLP4mZrp9K0s/D0eeeSwqOa3WC
HDW2T/ybgpYD/w1ZjWoNuwYAAA==

------------=_1583532846-65437-14--
