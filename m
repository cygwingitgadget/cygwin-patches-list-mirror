Return-Path: <cygwin-patches-return-2176-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24799 invoked by alias); 12 May 2002 15:33:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24780 invoked from network); 12 May 2002 15:33:12 -0000
Message-ID: <3CDE8B30.95496DFA@cistron.nl>
Date: Sun, 12 May 2002 08:33:00 -0000
From: Ton van Overbeek <tvoverbe@cistron.nl>
X-Accept-Language: en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com, cygwin@cygwin.com
Subject: [PATCH] Get recursive grep to work on Win9x
Content-Type: multipart/mixed;
 boundary="------------E06305C056C3C2E5B8672FAE"
X-SW-Source: 2002-q2/txt/msg00160.txt.bz2

This is a multi-part message in MIME format.
--------------E06305C056C3C2E5B8672FAE
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 1312

There have been various reports over time that recursive grep is not
working on Win9x. For every directory you get a 'Permission denied'
error.
Also there have been reports that using open(2) to open a directory
readonly on Win9x fails.
Both have the same cause.

open(2) calls _open in the cygwin1.dll (See source file syscalls.cc).
When you open a file (or directory) it creates a file_handler
and calls fhandler_base::open (See source file fhandler.cc).
fhandler_base::open adds the FILE_FLAG_BACKUP_SEMANTICS to
the file_attributes for the Win32 CreateFile call in case you
open a directory.
This way of opening a directory is only supported on WinNT and not
on Win9x. See MSDN.
Hence the reports that grep -R works on NT and not on 9x.

To get grep to work on 9x, the fix is simple: get fhandler_base::open
to set the error EISDIR when you try to open a directory.
This is *not* strictly POSIX. According to POSIX open should only
return EISDIR when you try to open a directory read/write or writeonly.
However it fixes the problem for grep.

The patch is simple. It makes use of the wincap.can_open_directories()
capability, which seems to be foreseen for exactly this type of problems.
However I could not find an other place where this capability is used
in the cygwin.dll.

Patch attached: fhandler.diff
--------------E06305C056C3C2E5B8672FAE
Content-Type: application/x-unknown-content-type-diff_auto_file;
 name="fhandler.diff"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="fhandler.diff"
Content-length: 700

LS0tIGZoYW5kbGVyLmNjCVN1biBNYXkgMTIgMTY6MzQ6MjIgMjAwMgorKysg
ZmhhbmRsZXIuY2Mub3JpZwlUaHUgTWF5ICAyIDA2OjEzOjQ2IDIwMDIKQEAg
LTM2OSwxNSArMzY5LDcgQEAKIAogICBmaWxlX2F0dHJpYnV0ZXMgPSBGSUxF
X0FUVFJJQlVURV9OT1JNQUw7CiAgIGlmIChmbGFncyAmIE9fRElST1BFTikK
LSAgICB7Ci0gICAgICBpZiAod2luY2FwLmNhbl9vcGVuX2RpcmVjdG9yaWVz
ICgpKQotICAgICAgICBmaWxlX2F0dHJpYnV0ZXMgfD0gRklMRV9GTEFHX0JB
Q0tVUF9TRU1BTlRJQ1M7Ci0gICAgICBlbHNlCi0gICAgICAgIHsKLSAgICAg
ICAgICBzZXRfZXJybm8gKEVJU0RJUik7Ci0gICAgICAgICAgZ290byBkb25l
OwotICAgICAgICB9Ci0gICAgfQorICAgIGZpbGVfYXR0cmlidXRlcyB8PSBG
SUxFX0ZMQUdfQkFDS1VQX1NFTUFOVElDUzsKICAgaWYgKGdldF9kZXZpY2Ug
KCkgPT0gRkhfU0VSSUFMKQogICAgIGZpbGVfYXR0cmlidXRlcyB8PSBGSUxF
X0ZMQUdfT1ZFUkxBUFBFRDsKIAo=

--------------E06305C056C3C2E5B8672FAE--
