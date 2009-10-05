Return-Path: <cygwin-patches-return-6697-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32605 invoked by alias); 5 Oct 2009 19:04:16 -0000
Received: (qmail 32302 invoked by uid 22791); 5 Oct 2009 19:04:13 -0000
X-SWARE-Spam-Status: No, hits=-3.5 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from out1.smtp.messagingengine.com (HELO out1.smtp.messagingengine.com) (66.111.4.25)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 05 Oct 2009 19:04:09 +0000
Received: from compute1.internal (compute1.internal [10.202.2.41]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id 894A082BD9 	for <cygwin-patches@cygwin.com>; Mon,  5 Oct 2009 15:04:07 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])   by compute1.internal (MEProxy); Mon, 05 Oct 2009 15:04:07 -0400
Received: from [192.168.1.3] (user-0c6sbc4.cable.mindspring.com [24.110.45.132]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id E6D8D13DD7; 	Mon,  5 Oct 2009 15:04:06 -0400 (EDT)
Message-ID: <4ACA4323.5080103@cwilson.fastmail.fm>
Date: Mon, 05 Oct 2009 19:04:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Add wrappers for ExitProcess, TerminateProcess
Content-Type: multipart/mixed;  boundary="------------090305000701030301000105"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00028.txt.bz2

This is a multi-part message in MIME format.
--------------090305000701030301000105
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 4135

Normally, posix programs should call abort(), exit(), _exit(), kill() --
or various pthread functions -- to terminate operation (either their
own, or that of some other processes/thread).  However, there are two
cases where the win32 ExitProcess and TerminateProcess functions might
justifiably be called:
  1) inside cygwin's own process startup/shutdown implementation
  2) "Native" programs that use the w32api throughout, but are compiled
using the cygwin compiler (e.g. without -mno-cygwin). [*]

However, the ExitProcess and TerminateProcess functions, when called
directly, do not allow for the 'exit status' maintained by cygwin to be
set. This can be a problem when such cygwin applications are exec'ed by
other cygwin apps: cygwin's code for exec'ing children doesn't ever
check the value of GetExitCodeProcess as set by these win32 functions,
if the child application is also a cygwin app.

The attached patch address this problem, by providing two wrappers:
  cygwin_terminate_process <--> TerminateProcess
  cygwin_exit_process      <--> ExitProcess
which simply set the cygwin exit code using the specified status value,
and then delegate to the underlying win32 call. This way, the parent
process -- if it is a cygwin process -- can access the exit code as
expected.

Note that TerminateProcess/ExitProcess -- and the new wrappers -- bypass
most of the cygwin shutdown code, so it is not recommended that ANY of
these functions be used in normal cygwin applications; they should be
used only when necessary -- e.g. case #1 above.

[*] In case #2, even with this patch, the client code must be modified
to call the wrappers. We can, in a follow-up patch, add objects to
libcygwin.a that explicitly force using the wrappers when client code
calls ExitProcess/TerminateProcess, but I'm not sure that's a good idea,
so I deferred that decision. Furthermore, if you're going to modify the
source code of the client, you might as well modify it to use the
recommended posix functions instead...so, in actuality, it's just case
#1 that really needs this support.

So, how should cygwin's process startup/shutdown code use these new
functions? Well, this can serve as the beginnings of a generic mechanism
for deferring error messages on process startup, using custom NTSTATUS
values (which have bit 29 set: eg. 0x[ea62]0000000).  At present, cygwin
maps any NTSTATUS values greater than 0xc00000000 to a posix exit value
of 127, because when bits 30 and 31 are set, this means
"STATUS_SEVERITY_ERROR", and cygwin assumes that these NTSTATUS values
will only occur during process startup -- thus, a posix 127 is
appropriate for "errors that occur during process startup". We could
revisit this assumption later.

One example of intended use is the v2 runtime pseudo-reloc stuff, posted
simultaneously on the cygwin-devel list.

But, here's a short example:
============================================
#include <stdio.h>
#include <windows.h>
#include <ntdef.h>
#include <sys/cygwin.h>

#define STATUS_ILLEGAL_DLL_RELOCATION        ((NTSTATUS) 0xc0000269)
#define STATUS_DLL_NOT_FOUND                 ((NTSTATUS) 0xc0000135)

/* custom NTSTATUS value */
#define STATUS_ILLEGAL_DLL_PSEUDO_RELOCATION ((NTSTATUS) 0xe0000269)

int main(int argc, char* argv[])
{
//cygwin_terminate_process (GetCurrentProcess(),
                            STATUS_ILLEGAL_DLL_PSEUDO_RELOCATION);
  cygwin_exit_process (STATUS_ILLEGAL_DLL_PSEUDO_RELOCATION);
  exit (1);
}
============================================

$ gcc -o foo foo.c
$ ./foo
$ echo $?
127

2009-10-04  Charles Wilson  <...>

	Add cygwin wrappers for ExitProcess and TerminateProcess.
	* include/sys/cygwin.h: Declare new functions
	cygwin_exit_process and cygwin_terminate_process.
	* cygwin.din: Add new functions cygwin_exit_process and
	cygwin_terminate_process.
	* dcrt0.cc (cygwin_exit_process): New function.
	(cygwin_terminate_process): New function.
	* include/cygwin/version.h: Bump version.
	* pinfo.h (pinfo::set_exit_code): New method.
	* pinfo.cc (pinfo::set_exit_code): New, refactored from...
	(pinfo::maybe_set_exit_code_from_windows): here. Call it.

--
Chuck




--------------090305000701030301000105
Content-Type: application/x-patch;
 name="01-cygwin-terminate-process.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="01-cygwin-terminate-process.patch"
Content-length: 9704

SW5kZXg6IGN5Z3dpbi5kaW4KPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1Mg
ZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9jeWd3aW4vY3lnd2luLmRpbix2
CnJldHJpZXZpbmcgcmV2aXNpb24gMS4yMTYKZGlmZiAtdSAtcCAtcjEuMjE2
IGN5Z3dpbi5kaW4KLS0tIGN5Z3dpbi5kaW4JMjYgU2VwIDIwMDkgMjE6MDE6
MTAgLTAwMDAJMS4yMTYKKysrIGN5Z3dpbi5kaW4JNSBPY3QgMjAwOSAxNjo1
ODo0OCAtMDAwMApAQCAtMjUwLDYgKzI1MCw3IEBAIGN5Z3dpbl9jb252X3Rv
X3dpbjMyX3BhdGggU0lHRkUKIGN5Z3dpbl9jcmVhdGVfcGF0aCBTSUdGRQog
Y3lnd2luX2RldGFjaF9kbGwgU0lHRkVfTUFZQkUKIGN5Z3dpbl9kbGxfaW5p
dCBOT1NJR0ZFCitjeWd3aW5fZXhpdF9wcm9jZXNzIE5PU0lHRkUKIGN5Z3dp
bl9pbnRlcm5hbCBOT1NJR0ZFCiBjeWd3aW5fbG9nb25fdXNlciBTSUdGRQog
Y3lnd2luX3Bvc2l4X3BhdGhfbGlzdF9wIE5PU0lHRkUKQEAgLTI1OCw2ICsy
NTksNyBAQCBjeWd3aW5fcG9zaXhfdG9fd2luMzJfcGF0aF9saXN0X2J1Zl9z
aXplCiBjeWd3aW5fc2V0X2ltcGVyc29uYXRpb25fdG9rZW4gU0lHRkUKIGN5
Z3dpbl9zcGxpdF9wYXRoIE5PU0lHRkUKIGN5Z3dpbl9zdGFja2R1bXAgU0lH
RkUKK2N5Z3dpbl90ZXJtaW5hdGVfcHJvY2VzcyBOT1NJR0ZFCiBjeWd3aW5f
dW1vdW50IFNJR0ZFCiBjeWd3aW5fd2luMzJfdG9fcG9zaXhfcGF0aF9saXN0
IFNJR0ZFCiBjeWd3aW5fd2luMzJfdG9fcG9zaXhfcGF0aF9saXN0X2J1Zl9z
aXplIFNJR0ZFCkluZGV4OiBkY3J0MC5jYwo9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09ClJDUyBmaWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL2N5Z3dpbi9kY3J0
MC5jYyx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS4zNjUKZGlmZiAtdSAtcCAt
cjEuMzY1IGRjcnQwLmNjCi0tLSBkY3J0MC5jYwkyIE9jdCAyMDA5IDE0OjU4
OjEwIC0wMDAwCTEuMzY1CisrKyBkY3J0MC5jYwk1IE9jdCAyMDA5IDE3OjQw
OjE3IC0wMDAwCkBAIC00MSw2ICs0MSw4IEBAIGRldGFpbHMuICovCiAKIAog
ZXh0ZXJuICJDIiB2b2lkIGN5Z3dpbl9leGl0IChpbnQpIF9fYXR0cmlidXRl
X18gKChub3JldHVybikpOworZXh0ZXJuICJDIiBCT09MIGN5Z3dpbl90ZXJt
aW5hdGVfcHJvY2VzcyAoSEFORExFLCBVSU5UKTsKK2V4dGVybiAiQyIgdm9p
ZCBjeWd3aW5fZXhpdF9wcm9jZXNzIChVSU5UKSBfX2F0dHJpYnV0ZV9fICgo
bm9yZXR1cm4pKTsKIGV4dGVybiAiQyIgdm9pZCBfX3Npbml0IChfcmVlbnQg
Kik7CiAKIHN0YXRpYyBpbnQgTk9fQ09QWSBlbnZjOwpAQCAtMTEzNiw2ICsx
MTM4LDY3IEBAIF9leGl0IChpbnQgbikKICAgZG9fZXhpdCAoKChEV09SRCkg
biAmIDB4ZmYpIDw8IDgpOwogfQogCisvKiBET0NUT09MLVNUQVJUCisgPHRp
dGxlPmN5Z3dpbl90ZXJtaW5hdGVfcHJvY2VzczwvdGl0bGU+CisKKyAgPGZ1
bmNzeW5vcHNpcz48ZnVuY3Byb3RvdHlwZT4KKyAgICA8ZnVuY2RlZj5leHRl
cm4gIkMiIEJPT0wKKyAgICAgIDxmdW5jdGlvbj5jeWd3aW5fdGVybWluYXRl
X3Byb2Nlc3M8L2Z1bmN0aW9uPgorICAgICAgPC9mdW5jZGVmPgorICAgICAg
PHBhcmFtZGVmPkhBTkRMRSA8cGFyYW1ldGVyPnByb2Nlc3M8L3BhcmFtZXRl
cj48L3BhcmFtZGVmPgorICAgICAgPHBhcmFtZGVmPlVJTlQgPHBhcmFtZXRl
cj5zdGF0dXM8L3BhcmFtZXRlcj48L3BhcmFtZGVmPgorICA8L2Z1bmNwcm90
b3R5cGU+PC9mdW5jc3lub3BzaXM+CisKKyAgPHBhcmE+Q3lnd2luLXNwZWNp
ZmljIHdyYXBwZXIgZm9yIHdpbjMyIFRlcm1pbmF0ZVByb2Nlc3MuIEl0Citl
bnN1cmVzIHRoYXQgaWYgdXNlZCB0byB0ZXJtaW5hdGUgdGhlIGN1cnJlbnQg
cHJvY2VzcywgdGhlbiB0aGUKK2NvcnJlY3QgZXhpdCBjb2RlIHdpbGwgYmUg
bWFkZSBhdmFpbGFibGUgdG8gdGhpcyBwcm9jZXNzJ3MgcGFyZW50CisoaWYg
dGhhdCBwYXJlbnQgaXMgYWxzbyBhIGN5Z3dpbiBwcm9jZXNzKS4gT3RoZXJ3
aXNlLCBpdCBzaW1wbHkKK2RlbGVnYXRlcyB0byB0aGUgd2luMzIgVGVybWlu
YXRlUHJvY2Vzcy48L3BhcmE+CisKKyAgPHBhcmE+VGhpcyBmdW5jdGlvbiBz
aG91bGQgYmUgdXNlZCBpbiBjeWd3aW4gcHJvZ3JhbXMgaW5zdGVhZAorb2Yg
VGVybWluYXRlUHJvY2Vzcy4gT3JkaW5hcmlseSwgaG93ZXZlciwgdGhlIEFO
U0kgYWJvcnQoKSBvciB0aGUKK1BPU0lYIF9leGl0KCkgZnVuY3Rpb24gc2hv
dWxkIGJlIHByZWZlcnJlZCBvdmVyIGVpdGhlcgorVGVybWluYXRlUHJvY2Vz
cyBvciBjeWd3aW5fdGVybWluYXRlX3Byb2Nlc3Mgd2hlbiB1c2VkIHRvIHRl
cm1pbmF0ZQordGhlIGN1cnJlbnQgcHJvY2Vzcy4gU2ltaWxhcmx5LCB0aGUg
UE9TSVgga2lsbCgpIGZ1bmN0aW9uIHNob3VsZAorYmUgdXNlZCB0byB0ZXJt
aW5hdGUgY3lnd2luIHByb2Nlc3NlcyBvdGhlciB0aGFuIHRoZSBjdXJyZW50
IG9uZS4KKzwvc2VjdDE+CisKKyAgIERPQ1RPT0wtRU5EICovCitleHRlcm4g
IkMiIEJPT0wKK2N5Z3dpbl90ZXJtaW5hdGVfcHJvY2VzcyAoSEFORExFIHBy
b2Nlc3MsIFVJTlQgc3RhdHVzKQoreworICBpZiAocHJvY2VzcyA9PSBHZXRD
dXJyZW50UHJvY2VzcygpKQorICAgIG15c2VsZi5zZXRfZXhpdF9jb2RlICgo
RFdPUkQpc3RhdHVzKTsKKworICByZXR1cm4gVGVybWluYXRlUHJvY2VzcyAo
cHJvY2Vzcywgc3RhdHVzKTsKK30KKworLyogRE9DVE9PTC1TVEFSVAorIDx0
aXRsZT5jeWd3aW5fZXhpdF9wcm9jZXNzPC90aXRsZT4KKworICA8ZnVuY3N5
bm9wc2lzPjxmdW5jcHJvdG90eXBlPgorICAgIDxmdW5jZGVmPmV4dGVybiAi
QyIgdm9pZAorICAgICAgPGZ1bmN0aW9uPmN5Z3dpbl9leGl0X3Byb2Nlc3M8
L2Z1bmN0aW9uPgorICAgICAgPC9mdW5jZGVmPgorICAgICAgPHBhcmFtZGVm
PlVJTlQgPHBhcmFtZXRlcj5zdGF0dXM8L3BhcmFtZXRlcj48L3BhcmFtZGVm
PgorICA8L2Z1bmNwcm90b3R5cGU+PC9mdW5jc3lub3BzaXM+CisKKyAgPHBh
cmE+Q3lnd2luLXNwZWNpZmljIHdyYXBwZXIgZm9yIHdpbjMyIEV4aXRQcm9j
ZXNzLCB3aGljaAorZW5zdXJlcyB0aGF0IHBhcmVudCBjeWd3aW4gcHJvY2Vz
cyByZWNlaXZlcyB0aGUgc3BlY2lmaWVkIHN0YXR1cworYXMgYW4gZXhpdCBj
b2RlLCBiZWZvcmUgY2FsbGluZyBFeGl0UHJvY2Vzcy4gVGhpcyBmdW5jdGlv
biBzaG91bGQKK2JlIHVzZWQgaW4gY3lnd2luIHByb2dyYW1zIGluc3RlYWQg
b2YgRXhpdFByb2Nlc3MuIE9yZGluYXJpbHksCitob3dldmVyLCB0aGUgQU5T
SSBleGl0KCkgZnVuY3Rpb24gc2hvdWxkIGJlIHByZWZlcnJlZCBvdmVyIGVp
dGhlcgorRXhpdFByb2Nlc3Mgb3IgY3lnd2luX2V4aXRfcHJvY2Vzcy48L3Bh
cmE+Cis8L3NlY3QxPgorCisgICBET0NUT09MLUVORCAqLworZXh0ZXJuICJD
IiB2b2lkCitjeWd3aW5fZXhpdF9wcm9jZXNzIChVSU5UIHN0YXR1cykKK3sK
KyAgbXlzZWxmLnNldF9leGl0X2NvZGUgKChEV09SRClzdGF0dXMpOworICBF
eGl0UHJvY2VzcyAoc3RhdHVzKTsKK30KKwogZXh0ZXJuICJDIiB2b2lkCiBf
X2FwaV9mYXRhbCAoY29uc3QgY2hhciAqZm10LCAuLi4pCiB7CkluZGV4OiBw
aW5mby5jYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBmaWxlOiAvY3Zz
L3NyYy9zcmMvd2luc3VwL2N5Z3dpbi9waW5mby5jYyx2CnJldHJpZXZpbmcg
cmV2aXNpb24gMS4yNTMKZGlmZiAtdSAtcCAtcjEuMjUzIHBpbmZvLmNjCi0t
LSBwaW5mby5jYwkxMiBKdWwgMjAwOSAyMToxNTo0NyAtMDAwMAkxLjI1Mwor
KysgcGluZm8uY2MJNSBPY3QgMjAwOSAxNjo1ODo0OSAtMDAwMApAQCAtMTM2
LDExICsxMzYsMTkgQEAgc3RhdHVzX2V4aXQgKERXT1JEIHgpCiAKICMgZGVm
aW5lIHNlbGYgKCp0aGlzKQogdm9pZAorcGluZm86OnNldF9leGl0X2NvZGUg
KERXT1JEIHgpCit7CisgIGV4dGVybiBpbnQgc2lnRXhlY2VkOworICBpZiAo
eCA+PSAweGMwMDAwMDAwVUwpCisgICAgeCA9IHN0YXR1c19leGl0ICh4KTsK
KyAgc2VsZi0+ZXhpdGNvZGUgPSBFWElUQ09ERV9TRVQgfCAoc2lnRXhlY2Vk
ID86ICh4ICYgMHhmZikgPDwgOCk7Cit9CisKK3ZvaWQKIHBpbmZvOjptYXli
ZV9zZXRfZXhpdF9jb2RlX2Zyb21fd2luZG93cyAoKQogewogICBEV09SRCB4
ID0gMHhkZWFkYmVlZjsKICAgRFdPUkQgb2V4aXRjb2RlID0gc2VsZi0+ZXhp
dGNvZGU7Ci0gIGV4dGVybiBpbnQgc2lnRXhlY2VkOwogCiAgIGlmIChoUHJv
Y2VzcyAmJiAhKHNlbGYtPmV4aXRjb2RlICYgRVhJVENPREVfU0VUKSkKICAg
ICB7CkBAIC0xNDgsOSArMTYwLDcgQEAgcGluZm86Om1heWJlX3NldF9leGl0
X2NvZGVfZnJvbV93aW5kb3dzIAogCQkJCQkJICAgcHJvY2VzcyBoYXNuJ3Qg
cXVpdGUgZXhpdGVkCiAJCQkJCQkgICBhZnRlciBjbG9zaW5nIHBpcGUgKi8K
ICAgICAgIEdldEV4aXRDb2RlUHJvY2VzcyAoaFByb2Nlc3MsICZ4KTsKLSAg
ICAgIGlmICh4ID49IDB4YzAwMDAwMDBVTCkKLQl4ID0gc3RhdHVzX2V4aXQg
KHgpOwotICAgICAgc2VsZi0+ZXhpdGNvZGUgPSBFWElUQ09ERV9TRVQgfCAo
c2lnRXhlY2VkID86ICh4ICYgMHhmZikgPDwgOCk7CisgICAgICBzZXRfZXhp
dF9jb2RlICh4KTsKICAgICB9CiAgIHNpZ3Byb2NfcHJpbnRmICgicGlkICVk
LCBleGl0IHZhbHVlIC0gb2xkICVwLCB3aW5kb3dzICVwLCBjeWd3aW4gJXAi
LAogCQkgIHNlbGYtPnBpZCwgb2V4aXRjb2RlLCB4LCBzZWxmLT5leGl0Y29k
ZSk7CkluZGV4OiBwaW5mby5oCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KUkNT
IGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2luL3BpbmZvLmgsdgpy
ZXRyaWV2aW5nIHJldmlzaW9uIDEuMTA4CmRpZmYgLXUgLXAgLXIxLjEwOCBw
aW5mby5oCi0tLSBwaW5mby5oCTIwIERlYyAyMDA4IDE3OjMyOjMxIC0wMDAw
CTEuMTA4CisrKyBwaW5mby5oCTUgT2N0IDIwMDkgMTY6NTg6NDkgLTAwMDAK
QEAgLTE1NSw2ICsxNTUsNyBAQCBwdWJsaWM6CiAgIH0KICAgdm9pZCBleGl0
IChEV09SRCBuKSBfX2F0dHJpYnV0ZV9fICgobm9yZXR1cm4sIHJlZ3Bhcm0o
MikpKTsKICAgdm9pZCBtYXliZV9zZXRfZXhpdF9jb2RlX2Zyb21fd2luZG93
cyAoKSBfX2F0dHJpYnV0ZV9fICgocmVncGFybSgxKSkpOworICB2b2lkIHNl
dF9leGl0X2NvZGUgKERXT1JEIG4pIF9fYXR0cmlidXRlX18gKChyZWdwYXJt
KDIpKSk7CiAgIF9waW5mbyAqb3BlcmF0b3IgLT4gKCkgY29uc3Qge3JldHVy
biBwcm9jaW5mbzt9CiAgIGludCBvcGVyYXRvciA9PSAocGluZm8gKngpIGNv
bnN0IHtyZXR1cm4geC0+cHJvY2luZm8gPT0gcHJvY2luZm87fQogICBpbnQg
b3BlcmF0b3IgPT0gKHBpbmZvICZ4KSBjb25zdCB7cmV0dXJuIHgucHJvY2lu
Zm8gPT0gcHJvY2luZm87fQpJbmRleDogaW5jbHVkZS9jeWd3aW4vdmVyc2lv
bi5oCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT0KUkNTIGZpbGU6IC9jdnMvc3Jj
L3NyYy93aW5zdXAvY3lnd2luL2luY2x1ZGUvY3lnd2luL3ZlcnNpb24uaCx2
CnJldHJpZXZpbmcgcmV2aXNpb24gMS4yOTkKZGlmZiAtdSAtcCAtcjEuMjk5
IHZlcnNpb24uaAotLS0gaW5jbHVkZS9jeWd3aW4vdmVyc2lvbi5oCTI2IFNl
cCAyMDA5IDIxOjAxOjEwIC0wMDAwCTEuMjk5CisrKyBpbmNsdWRlL2N5Z3dp
bi92ZXJzaW9uLmgJNSBPY3QgMjAwOSAxNjo1ODo0OSAtMDAwMApAQCAtMzY4
LDEyICszNjgsMTMgQEAgZGV0YWlscy4gKi8KICAgICAgIDIxMjogQWRkIGFu
ZCBleHBvcnQgbGlic3RkYysrIG1hbGxvYyB3cmFwcGVycy4KICAgICAgIDIx
MzogRXhwb3J0IGNhbm9uaWNhbGl6ZV9maWxlX25hbWUsIGVhY2Nlc3MsIGV1
aWRhY2Nlc3MuCiAgICAgICAyMTQ6IEV4cG9ydCBleGVjdnBlLCBmZXhlY3Zl
LgorICAgICAgMjE1OiBFeHBvcnQgY3lnd2luX3Rlcm1pbmF0ZV9wcm9jZXNz
LCBjeWd3aW5fZXhpdF9wcm9jZXNzLgogICAgICAqLwogCiAgICAgIC8qIE5v
dGUgdGhhdCB3ZSBmb3Jnb3QgdG8gYnVtcCB0aGUgYXBpIGZvciB1YWxhcm0s
IHN0cnRvbGwsIHN0cnRvdWxsICovCiAKICNkZWZpbmUgQ1lHV0lOX1ZFUlNJ
T05fQVBJX01BSk9SIDAKLSNkZWZpbmUgQ1lHV0lOX1ZFUlNJT05fQVBJX01J
Tk9SIDIxNAorI2RlZmluZSBDWUdXSU5fVkVSU0lPTl9BUElfTUlOT1IgMjE1
CiAKICAgICAgLyogVGhlcmUgaXMgYWxzbyBhIGNvbXBhdGliaXR5IHZlcnNp
b24gbnVtYmVyIGFzc29jaWF0ZWQgd2l0aCB0aGUKIAlzaGFyZWQgbWVtb3J5
IHJlZ2lvbnMuICBJdCBpcyBpbmNyZW1lbnRlZCB3aGVuIGluY29tcGF0aWJs
ZQpJbmRleDogaW5jbHVkZS9zeXMvY3lnd2luLmgKPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQpSQ1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9jeWd3aW4v
aW5jbHVkZS9zeXMvY3lnd2luLmgsdgpyZXRyaWV2aW5nIHJldmlzaW9uIDEu
ODAKZGlmZiAtdSAtcCAtcjEuODAgY3lnd2luLmgKLS0tIGluY2x1ZGUvc3lz
L2N5Z3dpbi5oCTcgSnVsIDIwMDkgMjA6MTI6NDQgLTAwMDAJMS44MAorKysg
aW5jbHVkZS9zeXMvY3lnd2luLmgJNSBPY3QgMjAwOSAxNjo1ODo0OSAtMDAw
MApAQCAtOTQsNiArOTQsOCBAQCBleHRlcm4gdm9pZCAqY3lnd2luX2NyZWF0
ZV9wYXRoIChjeWd3aW5fCiBleHRlcm4gcGlkX3QgY3lnd2luX3dpbnBpZF90
b19waWQgKGludCk7CiBleHRlcm4gaW50IGN5Z3dpbl9wb3NpeF9wYXRoX2xp
c3RfcCAoY29uc3QgY2hhciAqKTsKIGV4dGVybiB2b2lkIGN5Z3dpbl9zcGxp
dF9wYXRoIChjb25zdCBjaGFyICosIGNoYXIgKiwgY2hhciAqKTsKK2V4dGVy
biB2b2lkIGN5Z3dpbl9leGl0X3Byb2Nlc3MgKHVuc2lnbmVkIGludCBzdGF0
dXMpIF9fYXR0cmlidXRlX18oKG5vcmV0dXJuKSk7CitleHRlcm4gQk9PTCBj
eWd3aW5fdGVybWluYXRlX3Byb2Nlc3MgKEhBTkRMRSBwcm9jZXNzLCB1bnNp
Z25lZCBpbnQgc3RhdHVzKTsKIAogc3RydWN0IF9fY3lnd2luX3BlcmZpbGUK
IHsK

--------------090305000701030301000105--
