Return-Path: <cygwin-patches-return-8321-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 66134 invoked by alias); 17 Feb 2016 05:28:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 66114 invoked by uid 89); 17 Feb 2016 05:28:28 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=1.1 required=5.0 tests=AWL,BAYES_20,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2 spammy=profil, behavioral, Called, 1526
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Wed, 17 Feb 2016 05:28:25 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id u1H5SAcP060771	for <cygwin-patches@cygwin.com>; Tue, 16 Feb 2016 21:28:10 -0800 (PST)	(envelope-from mark@maxrnd.com)
Received: from 76-217-5-154.lightspeed.irvnca.sbcglobal.net(76.217.5.154), claiming to be "[192.168.1.100]" via SMTP by m0.truegem.net, id smtpduJTRuk; Tue Feb 16 21:28:00 2016
From: Mark Geisert <mark@maxrnd.com>
Subject: gprof profiling of multi-threaded Cygwin programs
To: cygwin-patches@cygwin.com
Message-ID: <56C404FF.502@maxrnd.com>
Date: Wed, 17 Feb 2016 05:28:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:42.0) Gecko/20100101 Firefox/42.0 SeaMonkey/2.39
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060108070509090906020902"
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00027.txt.bz2

This is a multi-part message in MIME format.
--------------060108070509090906020902
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 2034

I've attached a patch set modifying Cygwin's profiling support to sample PC 
values of all an application's threads, not just the main thread.  There is no 
change to how profiling is requested: just compile and link the app with "-pg" 
as usual.  The profiling info is dumped into file gmon.out as usual.

There is a behavioral change that ought to be documented somewhere:  If a 
gmon.out file exists when a profiled application exits, the app will now dump 
its profiling info into another file gmon.outXXXXXX where mkstemp() replaces the 
Xs with random alphanumerics.  I added this functionality to allow a profiled 
program to fork() yet retain profiling info for both parent and child.  The old 
behavior was to simply overwrite any existing gmon.out file.

There is no change to the normal Cygwin execution paths if profiling is not 
enabled.  And when it is enabled, only the one profiling thread per profiled app 
is doing more work than it used to.

Here's a change log of the modifications; all files are in winsup/cygwin:

         * common.din (cygheap_profthr_all): Export.
         * cygheap.cc (cygheap_profthr_all): Implement a C-callable function
         that runs cygheap's threadlist handing each pthread's thread handle
         in turn to profthr_byhandle().
         * gmon.c (_mcleanup): Added support for multiple simultaneous
         gmon.out* files created when necessary using mkstemp(). Added
         #include <errno.h>, added extern decl for _setmode().
         * gmon.h (struct gmonparam): Made state decl volatile.
         * mcount.c (_MCOUNT_DECL): Changed stores into gmonparam.state to use
         Interlocked operations. Added #include "winsup.h", updated commentary.
         * profil.c (profthr_byhandle): New function abstracting out the
         updating of profile counters based on a thread handle.
         (profthr_func): Updated to call profthr_byhandle() to sample the main
         thread then call cygheap_profthr_all() to sample all other pthreads.

Thanks for reading,

..mark

--------------060108070509090906020902
Content-Type: text/plain; charset=UTF-8;
 name="mt-profiling.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="mt-profiling.patch"
Content-length: 7288

ZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vY29tbW9uLmRpbiBiL3dpbnN1
cC9jeWd3aW4vY29tbW9uLmRpbgppbmRleCA5NTg0ZDA5Li4yNDNmZDAxIDEw
MDY0NAotLS0gYS93aW5zdXAvY3lnd2luL2NvbW1vbi5kaW4KKysrIGIvd2lu
c3VwL2N5Z3dpbi9jb21tb24uZGluCkBAIC0yNjksNiArMjY5LDcgQEAgY3Rp
bWUgU0lHRkUKIGN0aW1lX3IgU0lHRkUKIGN1c2VyaWQgTk9TSUdGRQogY3dh
aXQgU0lHRkUKK2N5Z2hlYXBfcHJvZnRocl9hbGwgTk9TSUdGRQogY3lnd2lu
X2F0dGFjaF9oYW5kbGVfdG9fZmQgU0lHRkUKIGN5Z3dpbl9jb252X3BhdGgg
U0lHRkUKIGN5Z3dpbl9jb252X3BhdGhfbGlzdCBTSUdGRQpkaWZmIC0tZ2l0
IGEvd2luc3VwL2N5Z3dpbi9jeWdoZWFwLmNjIGIvd2luc3VwL2N5Z3dpbi9j
eWdoZWFwLmNjCmluZGV4IDY0OTM0ODUuLjUxNTlkMzAgMTAwNjQ0Ci0tLSBh
L3dpbnN1cC9jeWd3aW4vY3lnaGVhcC5jYworKysgYi93aW5zdXAvY3lnd2lu
L2N5Z2hlYXAuY2MKQEAgLTc0NCwzICs3NDQsMTYgQEAgaW5pdF9jeWdoZWFw
OjpmaW5kX3RscyAoaW50IHNpZywgYm9vbCYgaXNzaWdfd2FpdCkKICAgICBX
YWl0Rm9yU2luZ2xlT2JqZWN0ICh0LT5tdXRleCwgSU5GSU5JVEUpOwogICBy
ZXR1cm4gdDsKIH0KKworLyogQ2FsbGVkIGZyb20gcHJvZmlsLmMgdG8gc2Ft
cGxlIGFsbCBub24tbWFpbiB0aHJlYWQgUEMgdmFsdWVzIGZvciBwcm9maWxp
bmcgKi8KK2V4dGVybiAiQyIgdm9pZAorY3lnaGVhcF9wcm9mdGhyX2FsbCAo
dm9pZCAoKnByb2Z0aHJfYnloYW5kbGUpIChIQU5ETEUpKQoreworICBpbnQg
aXggPSAtMTsKKyAgd2hpbGUgKCsraXggPCAoaW50KSBudGhyZWFkcykKKyAg
ICB7CisgICAgICBfY3lndGxzICp0bHMgPSBjeWdoZWFwLT50aHJlYWRsaXN0
W2l4XS50aHJlYWQ7CisgICAgICBpZiAodGxzLT50aWQpCisJcHJvZnRocl9i
eWhhbmRsZSAodGxzLT50aWQtPndpbjMyX29ial9pZCk7CisgICAgfQorfQpk
aWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9nbW9uLmMgYi93aW5zdXAvY3ln
d2luL2dtb24uYwppbmRleCA5NmIxMTg5Li4wYjdlY2MwIDEwMDY0NAotLS0g
YS93aW5zdXAvY3lnd2luL2dtb24uYworKysgYi93aW5zdXAvY3lnd2luL2dt
b24uYwpAQCAtMzYsNiArMzYsNyBAQCBzdGF0aWMgY2hhciByY3NpZFtdID0g
IiRPcGVuQlNEOiBnbW9uLmMsdiAxLjggMTk5Ny8wNy8yMyAyMToxMToyNyBr
c3RhaWxleSBFeHAgJAogICogVGhlIGRpZmZlcmVuY2VzIHNob3VsZCBiZSB3
aXRoaW4gX19NSU5HVzMyX18gZ3VhcmQuCiAgKi8KIAorI2luY2x1ZGUgPGVy
cm5vLmg+CiAjaW5jbHVkZSA8ZmNudGwuaD4KICNpbmNsdWRlIDxzdGRsaWIu
aD4KICNpbmNsdWRlIDxzdGRpby5oPgpAQCAtNDksNiArNTAsNyBAQCBzdGF0
aWMgY2hhciByY3NpZFtdID0gIiRPcGVuQlNEOiBnbW9uLmMsdiAxLjggMTk5
Ny8wNy8yMyAyMToxMToyNyBrc3RhaWxleSBFeHAgJAogCiAvKiBYWFggbmVl
ZGVkPyAqLwogLy9leHRlcm4gY2hhciAqbWluYnJrIF9fYXNtICgibWluYnJr
Iik7CitleHRlcm4gaW50IF9zZXRtb2RlKGludCwgaW50KTsKIAogI2lmZGVm
IF9XSU42NAogI2RlZmluZSBNSU5VU19PTkVfUCAoLTFMTCkKQEAgLTE1Miw2
ICsxNTQsNyBAQCB2b2lkCiBfbWNsZWFudXAodm9pZCkKIHsKIAlzdGF0aWMg
Y2hhciBnbW9uX291dFtdID0gImdtb24ub3V0IjsKKwlzdGF0aWMgY2hhciBn
bW9uX3RlbXBsYXRlW10gPSAiZ21vbi5vdXRYWFhYWFgiOwogCWludCBmZDsK
IAlpbnQgaHo7CiAJaW50IGZyb21pbmRleDsKQEAgLTIyMiw3ICsyMjUsMTQg
QEAgX21jbGVhbnVwKHZvaWQpCiAJcHJvZmZpbGUgPSBnbW9uX291dDsKICNl
bmRpZgogCi0JZmQgPSBvcGVuKHByb2ZmaWxlICwgT19DUkVBVHxPX1RSVU5D
fE9fV1JPTkxZfE9fQklOQVJZLCAwNjY2KTsKKwlmZCA9IG9wZW4ocHJvZmZp
bGUsIE9fQ1JFQVR8T19FWENMfE9fVFJVTkN8T19XUk9OTFl8T19CSU5BUlks
IDA2NjYpOworCWlmIChmZCA8IDAgJiYgZXJybm8gPT0gRUVYSVNUKSB7CisJ
CWZkID0gbWtzdGVtcChnbW9uX3RlbXBsYXRlKTsKKwkJaWYgKGZkID49IDAp
IHsKKwkJCV9zZXRtb2RlKGZkLCBPX0JJTkFSWSk7CisJCQlmY2htb2QoZmQs
IDA2NDQpOworCQl9CisJfQogCWlmIChmZCA8IDApIHsKIAkJcGVycm9yKCBw
cm9mZmlsZSApOwogCQlyZXR1cm47CmRpZmYgLS1naXQgYS93aW5zdXAvY3ln
d2luL2dtb24uaCBiL3dpbnN1cC9jeWd3aW4vZ21vbi5oCmluZGV4IDA5MzJl
ZDkuLmIwZmI0NzkgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vZ21vbi5o
CisrKyBiL3dpbnN1cC9jeWd3aW4vZ21vbi5oCkBAIC0xNTMsNyArMTUzLDcg
QEAgc3RydWN0IHJhd2FyYyB7CiAgKiBUaGUgcHJvZmlsaW5nIGRhdGEgc3Ry
dWN0dXJlcyBhcmUgaG91c2VkIGluIHRoaXMgc3RydWN0dXJlLgogICovCiBz
dHJ1Y3QgZ21vbnBhcmFtIHsKLQlpbnQJCXN0YXRlOworCXZvbGF0aWxlIGlu
dAlzdGF0ZTsKIAl1X3Nob3J0CQkqa2NvdW50OwogCXNpemVfdAkJa2NvdW50
c2l6ZTsKIAl1X3Nob3J0CQkqZnJvbXM7CmRpZmYgLS1naXQgYS93aW5zdXAv
Y3lnd2luL21jb3VudC5jIGIvd2luc3VwL2N5Z3dpbi9tY291bnQuYwppbmRl
eCBmYWQ2NzI4Li42MTExYjM1IDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2lu
L21jb3VudC5jCisrKyBiL3dpbnN1cC9jeWd3aW4vbWNvdW50LmMKQEAgLTQx
LDYgKzQxLDcgQEAgc3RhdGljIGNoYXIgcmNzaWRbXSA9ICIkT3BlbkJTRDog
bWNvdW50LmMsdiAxLjYgMTk5Ny8wNy8yMyAyMToxMToyNyBrc3RhaWxleSBF
eHAKICNlbmRpZgogI2luY2x1ZGUgPHN5cy90eXBlcy5oPgogI2luY2x1ZGUg
Imdtb24uaCIKKyNpbmNsdWRlICJ3aW5zdXAuaCIKIAogLyoKICAqIG1jb3Vu
dCBpcyBjYWxsZWQgb24gZW50cnkgdG8gZWFjaCBmdW5jdGlvbiBjb21waWxl
ZCB3aXRoIHRoZSBwcm9maWxpbmcKQEAgLTcwLDExICs3MSwxMiBAQCBfTUNP
VU5UX0RFQ0wgKHNpemVfdCBmcm9tcGMsIHNpemVfdCBzZWxmcGMpCiAJcCA9
ICZfZ21vbnBhcmFtOwogCS8qCiAJICogY2hlY2sgdGhhdCB3ZSBhcmUgcHJv
ZmlsaW5nCi0JICogYW5kIHRoYXQgd2UgYXJlbid0IHJlY3Vyc2l2ZWx5IGlu
dm9rZWQuCisJICogYW5kIHRoYXQgd2UgYXJlbid0IHJlY3Vyc2l2ZWx5IGlu
dm9rZWQgYnkgdGhpcyB0aHJlYWQKKwkgKiBvciBlbnRlcmVkIGFuZXcgYnkg
YW55IG90aGVyIHRocmVhZC4KIAkgKi8KLQlpZiAocC0+c3RhdGUgIT0gR01P
Tl9QUk9GX09OKQorCWlmIChJbnRlcmxvY2tlZENvbXBhcmVFeGNoYW5nZSAo
CisJCSAgICAmcC0+c3RhdGUsIEdNT05fUFJPRl9CVVNZLCBHTU9OX1BST0Zf
T04pICE9IEdNT05fUFJPRl9PTikKIAkJcmV0dXJuOwotCXAtPnN0YXRlID0g
R01PTl9QUk9GX0JVU1k7CiAJLyoKIAkgKiBjaGVjayB0aGF0IGZyb21wY2lu
ZGV4IGlzIGEgcmVhc29uYWJsZSBwYyB2YWx1ZS4KIAkgKiBmb3IgZXhhbXBs
ZToJc2lnbmFsIGNhdGNoZXJzIGdldCBjYWxsZWQgZnJvbSB0aGUgc3RhY2ss
CkBAIC0xNjIsMTAgKzE2NCwxMCBAQCBfTUNPVU5UX0RFQ0wgKHNpemVfdCBm
cm9tcGMsIHNpemVfdCBzZWxmcGMpCiAJCX0KIAl9CiBkb25lOgotCXAtPnN0
YXRlID0gR01PTl9QUk9GX09OOworCUludGVybG9ja2VkRXhjaGFuZ2UgKCZw
LT5zdGF0ZSwgR01PTl9QUk9GX09OKTsKIAlyZXR1cm47CiBvdmVyZmxvdzoK
LQlwLT5zdGF0ZSA9IEdNT05fUFJPRl9FUlJPUjsKKwlJbnRlcmxvY2tlZEV4
Y2hhbmdlICgmcC0+c3RhdGUsIEdNT05fUFJPRl9FUlJPUik7CiAJcmV0dXJu
OwogfQogCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL3Byb2ZpbC5jIGIv
d2luc3VwL2N5Z3dpbi9wcm9maWwuYwppbmRleCBlYjQxYzA4Li5mNzZmZGE1
IDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL3Byb2ZpbC5jCisrKyBiL3dp
bnN1cC9jeWd3aW4vcHJvZmlsLmMKQEAgLTI4LDYgKzI4LDggQEAKIC8qIGds
b2JhbCBwcm9maW5mbyBmb3IgcHJvZmlsKCkgY2FsbCAqLwogc3RhdGljIHN0
cnVjdCBwcm9maW5mbyBwcm9mOwogCitleHRlcm4gdm9pZCBjeWdoZWFwX3By
b2Z0aHJfYWxsICh2b2lkICgqKSAoSEFORExFKSk7CisKIC8qIEdldCB0aGUg
cGMgZm9yIHRocmVhZCBUSFIgKi8KIAogc3RhdGljIHNpemVfdApAQCAtNjUs
MjUgKzY3LDM2IEBAIHByaW50X3Byb2YgKHN0cnVjdCBwcm9maW5mbyAqcCkK
IH0KICNlbmRpZgogCi0vKiBFdmVyeXRpbWUgd2Ugd2FrZSB1cCB1c2UgdGhl
IG1haW4gdGhyZWFkIHBjIHRvIGhhc2ggaW50byB0aGUgY2VsbCBpbiB0aGUK
LSAgIHByb2ZpbGUgYnVmZmVyIEFSRy4gKi8KKy8qIEV2ZXJ5IHRpbWUgd2Ug
d2FrZSB1cCBzYW1wbGUgdGhlIG1haW4gdGhyZWFkJ3MgcGMgdG8gaGFzaCBp
bnRvIHRoZSBjZWxsCisgICBpbiB0aGUgcHJvZmlsZSBidWZmZXIgQVJHLiAg
VGhlbiBhbGwgb3RoZXIgcHRocmVhZHMnIHBjJ3MgYXJlIHNhbXBsZWQuICAq
LwogCi1zdGF0aWMgdm9pZCBDQUxMQkFDSyBwcm9mdGhyX2Z1bmMgKExQVk9J
RCk7CitzdGF0aWMgdm9pZAorcHJvZnRocl9ieWhhbmRsZSAoSEFORExFIHRo
cikKK3sKKyAgc2l6ZV90IGlkeDsKKyAgc2l6ZV90IHBjID0gKHNpemVfdCkg
Z2V0X3RocnBjICh0aHIpOworCisgIC8vIGNvZGUgYXNzdW1lcyB0aGVyZSBp
cyBvbmx5IG9uZSBwcm9maW5mbyBpbiBwbGF5OiB0aGUgc3RhdGljIHByb2Yg
dXAgdG9wCisgIGlmIChwYyA+PSBwcm9mLmxvd3BjICYmIHBjIDwgcHJvZi5o
aWdocGMpCisgICAgeworICAgICAgaWR4ID0gUFJPRklEWCAocGMsIHByb2Yu
bG93cGMsIHByb2Yuc2NhbGUpOworICAgICAgcHJvZi5jb3VudGVyW2lkeF0r
KzsKKyAgICB9Cit9CiAKIHN0YXRpYyB2b2lkIENBTExCQUNLCiBwcm9mdGhy
X2Z1bmMgKExQVk9JRCBhcmcpCiB7CiAgIHN0cnVjdCBwcm9maW5mbyAqcCA9
IChzdHJ1Y3QgcHJvZmluZm8gKikgYXJnOwotICBzaXplX3QgcGMsIGlkeDsK
IAogICBmb3IgKDs7KQogICAgIHsKLSAgICAgIHBjID0gKHNpemVfdCkgZ2V0
X3RocnBjIChwLT50YXJndGhyKTsKLSAgICAgIGlmIChwYyA+PSBwLT5sb3dw
YyAmJiBwYyA8IHAtPmhpZ2hwYykKLQl7Ci0JICBpZHggPSBQUk9GSURYIChw
YywgcC0+bG93cGMsIHAtPnNjYWxlKTsKLQkgIHAtPmNvdW50ZXJbaWR4XSsr
OwotCX0KKyAgICAgIC8vIHJlY29yZCBwcm9maWxpbmcgc2FtcGxlIGZvciBt
YWluIHRocmVhZAorICAgICAgcHJvZnRocl9ieWhhbmRsZSAocC0+dGFyZ3Ro
cik7CisKKyAgICAgIC8vIHJlY29yZCBwcm9maWxpbmcgc2FtcGxlcyBmb3Ig
b3RoZXIgcHRocmVhZHMsIGlmIGFueQorICAgICAgY3lnaGVhcF9wcm9mdGhy
X2FsbCAocHJvZnRocl9ieWhhbmRsZSk7CisKICNpZiAwCiAgICAgICBwcmlu
dF9wcm9mIChwKTsKICNlbmRpZgo=

--------------060108070509090906020902--
