Return-Path: <cygwin-patches-return-8915-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 42581 invoked by alias); 12 Nov 2017 18:54:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 42153 invoked by uid 89); 12 Nov 2017 18:54:40 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-21.9 required=5.0 tests=AWL,BAYES_50,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2 spammy=objective, 5.6, repair, 64
X-HELO: smtp-out-no.shaw.ca
Received: from smtp-out-no.shaw.ca (HELO smtp-out-no.shaw.ca) (64.59.134.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 12 Nov 2017 18:54:35 +0000
Received: from [192.168.1.100] ([24.64.240.204])	by shaw.ca with SMTP	id DxAKe19vLI8mCDxALeoKYK; Sun, 12 Nov 2017 11:39:34 -0700
X-Authority-Analysis: v=2.2 cv=HahkdmM8 c=1 sm=1 tr=0 a=MVEHjbUiAHxQW0jfcDq5EA==:117 a=MVEHjbUiAHxQW0jfcDq5EA==:17 a=r77TgQKjGQsHNAKrUKIA:9 a=w5aJ8kaLLAry8Qfnm_kA:9 a=pILNOxqGKmIA:10 a=7vT8eNxyAAAA:8 a=w_pzkKWiAAAA:8 a=hwcQFGI2mwX33yRv7DEA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=Bni-mUcJ5TmySuvH:21 a=QEXdDO2ut3YA:10 a=tMPTF2wDCtEA:10 a=uvLZkzHzGa8A:10 a=CdiWusdWvyIA:10 a=NWVoK91CQyQA:10 a=Mzmg39azMnTNyelF985k:22 a=sRI3_1zDfAgwuvI8zelB:22
Reply-To: Brian.Inglis@SystematicSw.ab.ca
To: cygwin-patches@cygwin.com
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Subject: [PATCH] Add FAQ 4.46 How do I fix find_fast_cwd warnings?
Message-ID: <ac78412d-748f-ed22-473e-9d101f7bde2f@SystematicSw.ab.ca>
Date: Sun, 12 Nov 2017 18:54:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2F57CFE5CEEC5D11625C6829"
X-CMAE-Envelope: MS4wfHiuBEs5N1cXVtBLeSSJDTyjPrFudLIICy4H23IOs3tNRCm2g5c9jk33dKXnlGjBy2gvieAQ/LP0ZoEF2y5d5UDuIPuvCuAbqlJ7vcduUCS32s8IgtyF Am6UKPk/czeQ93UfmGix2RDNgSqIZ4WAAO1iFA6S3Czqy5tbZXhpULIxnVE4Y6x1pImx3nvqPc0lU+XTXHsisWoGX7Y7pOwd40Q=
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00045.txt.bz2

This is a multi-part message in MIME format.
--------------2F57CFE5CEEC5D11625C6829
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-length: 429

Having responded to some of these posts and being prompted by the suggestion in
a reply to one by "Cyg simple", I attach an offering, in the off chance that
anyone affected might actually check the FAQ or find it in a search. ;^>

A FAQ entry for app developers about how to go about Cygwin installs and
upgrades as part of their apps would also be a good addition?

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

--------------2F57CFE5CEEC5D11625C6829
Content-Type: text/plain; charset=UTF-8;
 name="0001-add-FAQ-4.46-How-do-I-fix-find_fast_cwd-warnings.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename*0="0001-add-FAQ-4.46-How-do-I-fix-find_fast_cwd-warnings.patch"
Content-length: 29553

=46rom fdd3ce05680ca5e26532a51b119388cdb358e98e Mon Sep 17 00:00:00 2001
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Date: Sun, 12 Nov 2017 11:22:17 -0700
Subject: [PATCH] add FAQ 4.46 How do I fix find_fast_cwd warnings?

---
 faq/faq.html | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/faq/faq.html b/faq/faq.html
index ee3bd9b7..6f01ab29 100644
--- a/faq/faq.html
+++ b/faq/faq.html
@@ -10,7 +10,7 @@ Can I bundle Cygwin with my product for free?
 </a></dt><dt>4.23. <a href=3D"faq.html#faq.using.older-cygwin-conflict">
 But doesn't that mean that if some application installs an older Cygwin
 DLL on top of a newer DLL, my application will break?
-</a></dt><dt>4.24. <a href=3D"faq.html#faq.using.missing-packages">Why isn=
't package XYZ available in Cygwin?</a></dt><dt>4.25. <a href=3D"faq.html#f=
aq.using.old-packages">Why is the Cygwin package of XYZ so out of date?</a>=
</dt><dt>4.26. <a href=3D"faq.html#faq.using.accessing-drives">How can I ac=
cess other drives?</a></dt><dt>4.27. <a href=3D"faq.html#faq.using.copy-and=
-paste">How can I copy and paste into Cygwin console windows?</a></dt><dt>4=
.28. <a href=3D"faq.html#faq.using.firewall">What firewall should I use wit=
h Cygwin? </a></dt><dt>4.29. <a href=3D"faq.html#faq.using.sharing-files">H=
ow can I share files between Unix and Windows?</a></dt><dt>4.30. <a href=3D=
"faq.html#faq.using.case-sensitive">Is Cygwin case-sensitive??</a></dt><dt>=
4.31. <a href=3D"faq.html#faq.using.dos-filenames">What about DOS special f=
ilenames?</a></dt><dt>4.32. <a href=3D"faq.html#faq.using.hangs">When it ha=
ngs, how do I get it back?</a></dt><dt>4.33. <a href=3D"faq.html#faq.using.=
directory-structure">Why the weird directory structure?</a></dt><dt>4.34. <=
a href=3D"faq.html#faq.using.anti-virus">How do anti-virus programs like Cy=
gwin?</a></dt><dt>4.35. <a href=3D"faq.html#faq.using.emacs">Is there a Cyg=
win port of GNU Emacs?</a></dt><dt>4.36. <a href=3D"faq.html#faq.using.xema=
cs">Is there a Cygwin port of XEmacs?</a></dt><dt>4.37. <a href=3D"faq.html=
#faq.using.symlinkstoppedworking">Why don't some of my old symlinks work an=
ymore?</a></dt><dt>4.38. <a href=3D"faq.html#faq.using.symlinks-samba">Why =
don't symlinks work on Samba-mounted filesystems?</a></dt><dt>4.39. <a href=
=3D"faq.html#faq.using.sshd-in-domain">How do I setup sshd in a domain?</a>=
</dt><dt>4.40. <a href=3D"faq.html#faq.using.ssh-pubkey-stops-working">Why =
does public key authentication with ssh fail after updating to Cygwin 1.7.3=
4 or later?</a></dt><dt>4.41. <a href=3D"faq.html#faq.using.same-with-rhost=
s">Why is my .rhosts file not recognized by rlogin anymore after updating t=
o Cygwin 1.7.34?</a></dt><dt>4.42. <a href=3D"faq.html#faq.using.same-with-=
permissions">Why do my files have extra permissions after updating to Cygwi=
n 1.7.34?</a></dt><dt>4.43. <a href=3D"faq.html#faq.using.tcl-tk">Why do my=
 Tk programs not work anymore?</a></dt><dt>4.44. <a href=3D"faq.html#faq.us=
ing.bloda">What applications have been found to interfere with Cygwin?</a><=
/dt><dt>4.45. <a href=3D"faq.html#faq.using.fixing-fork-failures">How do I =
fix fork() failures?</a></dt></dl></dd><dt>5.  <a href=3D"faq.html#faq.api"=
>Cygwin API Questions</a></dt><dd><dl><dt>5.1. <a href=3D"faq.html#faq.api.=
everything">How does everything work?</a></dt><dt>5.2. <a href=3D"faq.html#=
faq.api.snapshots">Are development snapshots for the Cygwin library availab=
le?</a></dt><dt>5.3. <a href=3D"faq.html#faq.api.cr-lf">How is the DOS/Unix=
 CR/LF thing handled?</a></dt><dt>5.4. <a href=3D"faq.html#faq.api.threads"=
>Is the Cygwin library multi-thread-safe?</a></dt><dt>5.5. <a href=3D"faq.h=
tml#faq.api.fork">How is fork() implemented?</a></dt><dt>5.6. <a href=3D"fa=
q.html#faq.api.globbing">How does wildcarding (globbing) work?</a></dt><dt>=
5.7. <a href=3D"faq.html#faq.api.symlinks">How do symbolic links work?</a><=
/dt><dt>5.8. <a href=3D"faq.html#faq.api.executables">Why do some files, wh=
ich are not executables have the 'x' type.</a></dt><dt>5.9. <a href=3D"faq.=
html#faq.api.secure">How secure is Cygwin in a multi-user environment?</a><=
/dt><dt>5.10. <a href=3D"faq.html#faq.api.net-functions">How do the net-rel=
ated functions work?</a></dt><dt>5.11. <a href=3D"faq.html#faq.api.winsock"=
>I don't want Unix sockets, how do I use normal Win32 winsock?</a></dt><dt>=
5.12. <a href=3D"faq.html#faq.api.versions">What version numbers are associ=
ated with Cygwin?</a></dt><dt>5.13. <a href=3D"faq.html#faq.api.timezone">W=
hy isn't timezone set correctly?</a></dt><dt>5.14. <a href=3D"faq.html#faq.=
api.mouse">Is there a mouse interface?</a></dt></dl></dd><dt>6.  <a href=3D=
"faq.html#faq.programming">Programming Questions</a></dt><dd><dl><dt>6.1. <=
a href=3D"faq.html#faq.programming.packages">How do I contribute a package?=
</a></dt><dt>6.2. <a href=3D"faq.html#faq.programming.contribute">How do I =
contribute to Cygwin?</a></dt><dt>6.3. <a href=3D"faq.html#faq.programming.=
huge-executables">Why are compiled executables so huge?!?</a></dt><dt>6.4. =
<a href=3D"faq.html#faq.programming.64bitporting">What do I have to look ou=
t for when porting applications to 64 bit Cygwin?</a></dt><dt>6.5. <a href=
=3D"faq.html#faq.programming.64bitporting-fail">My project doesn't build at=
 all on 64 bit Cygwin.  What's up?</a></dt><dt>6.6. <a href=3D"faq.html#faq=
.programming.64bitporting-cygwin64">Why is __CYGWIN64__ not defined for 64 =
bit?</a></dt><dt>6.7. <a href=3D"faq.html#faq.programming.glibc">Where is g=
libc?</a></dt><dt>6.8. <a href=3D"faq.html#faq.programming.objective-c">Whe=
re is Objective C?</a></dt><dt>6.9. <a href=3D"faq.html#faq.programming.mak=
e-execvp">Why does my make fail on Cygwin with an execvp error? </a></dt><d=
t>6.10. <a href=3D"faq.html#faq.programming.ipc">How can I use IPC, or why =
do I get a Bad system call
+</a></dt><dt>4.24. <a href=3D"faq.html#faq.using.missing-packages">Why isn=
't package XYZ available in Cygwin?</a></dt><dt>4.25. <a href=3D"faq.html#f=
aq.using.old-packages">Why is the Cygwin package of XYZ so out of date?</a>=
</dt><dt>4.26. <a href=3D"faq.html#faq.using.accessing-drives">How can I ac=
cess other drives?</a></dt><dt>4.27. <a href=3D"faq.html#faq.using.copy-and=
-paste">How can I copy and paste into Cygwin console windows?</a></dt><dt>4=
.28. <a href=3D"faq.html#faq.using.firewall">What firewall should I use wit=
h Cygwin? </a></dt><dt>4.29. <a href=3D"faq.html#faq.using.sharing-files">H=
ow can I share files between Unix and Windows?</a></dt><dt>4.30. <a href=3D=
"faq.html#faq.using.case-sensitive">Is Cygwin case-sensitive??</a></dt><dt>=
4.31. <a href=3D"faq.html#faq.using.dos-filenames">What about DOS special f=
ilenames?</a></dt><dt>4.32. <a href=3D"faq.html#faq.using.hangs">When it ha=
ngs, how do I get it back?</a></dt><dt>4.33. <a href=3D"faq.html#faq.using.=
directory-structure">Why the weird directory structure?</a></dt><dt>4.34. <=
a href=3D"faq.html#faq.using.anti-virus">How do anti-virus programs like Cy=
gwin?</a></dt><dt>4.35. <a href=3D"faq.html#faq.using.emacs">Is there a Cyg=
win port of GNU Emacs?</a></dt><dt>4.36. <a href=3D"faq.html#faq.using.xema=
cs">Is there a Cygwin port of XEmacs?</a></dt><dt>4.37. <a href=3D"faq.html=
#faq.using.symlinkstoppedworking">Why don't some of my old symlinks work an=
ymore?</a></dt><dt>4.38. <a href=3D"faq.html#faq.using.symlinks-samba">Why =
don't symlinks work on Samba-mounted filesystems?</a></dt><dt>4.39. <a href=
=3D"faq.html#faq.using.sshd-in-domain">How do I setup sshd in a domain?</a>=
</dt><dt>4.40. <a href=3D"faq.html#faq.using.ssh-pubkey-stops-working">Why =
does public key authentication with ssh fail after updating to Cygwin 1.7.3=
4 or later?</a></dt><dt>4.41. <a href=3D"faq.html#faq.using.same-with-rhost=
s">Why is my .rhosts file not recognized by rlogin anymore after updating t=
o Cygwin 1.7.34?</a></dt><dt>4.42. <a href=3D"faq.html#faq.using.same-with-=
permissions">Why do my files have extra permissions after updating to Cygwi=
n 1.7.34?</a></dt><dt>4.43. <a href=3D"faq.html#faq.using.tcl-tk">Why do my=
 Tk programs not work anymore?</a></dt><dt>4.44. <a href=3D"faq.html#faq.us=
ing.bloda">What applications have been found to interfere with Cygwin?</a><=
/dt><dt>4.45. <a href=3D"faq.html#faq.using.fixing-fork-failures">How do I =
fix fork() failures?</a></dt><dt>4.46. <a href=3D"faq.html#faq.using.fixing=
-find_fast_cwd-warnings">How do I fix find_fast_cwd warnings?</a></dt></dl>=
</dd><dt>5.  <a href=3D"faq.html#faq.api">Cygwin API Questions</a></dt><dd>=
<dl><dt>5.1. <a href=3D"faq.html#faq.api.everything">How does everything wo=
rk?</a></dt><dt>5.2. <a href=3D"faq.html#faq.api.snapshots">Are development=
 snapshots for the Cygwin library available?</a></dt><dt>5.3. <a href=3D"fa=
q.html#faq.api.cr-lf">How is the DOS/Unix CR/LF thing handled?</a></dt><dt>=
5.4. <a href=3D"faq.html#faq.api.threads">Is the Cygwin library multi-threa=
d-safe?</a></dt><dt>5.5. <a href=3D"faq.html#faq.api.fork">How is fork() im=
plemented?</a></dt><dt>5.6. <a href=3D"faq.html#faq.api.globbing">How does =
wildcarding (globbing) work?</a></dt><dt>5.7. <a href=3D"faq.html#faq.api.s=
ymlinks">How do symbolic links work?</a></dt><dt>5.8. <a href=3D"faq.html#f=
aq.api.executables">Why do some files, which are not executables have the '=
x' type.</a></dt><dt>5.9. <a href=3D"faq.html#faq.api.secure">How secure is=
 Cygwin in a multi-user environment?</a></dt><dt>5.10. <a href=3D"faq.html#=
faq.api.net-functions">How do the net-related functions work?</a></dt><dt>5=
.11. <a href=3D"faq.html#faq.api.winsock">I don't want Unix sockets, how do=
 I use normal Win32 winsock?</a></dt><dt>5.12. <a href=3D"faq.html#faq.api.=
versions">What version numbers are associated with Cygwin?</a></dt><dt>5.13=
. <a href=3D"faq.html#faq.api.timezone">Why isn't timezone set correctly?</=
a></dt><dt>5.14. <a href=3D"faq.html#faq.api.mouse">Is there a mouse interf=
ace?</a></dt></dl></dd><dt>6.  <a href=3D"faq.html#faq.programming">Program=
ming Questions</a></dt><dd><dl><dt>6.1. <a href=3D"faq.html#faq.programming=
.packages">How do I contribute a package?</a></dt><dt>6.2. <a href=3D"faq.h=
tml#faq.programming.contribute">How do I contribute to Cygwin?</a></dt><dt>=
6.3. <a href=3D"faq.html#faq.programming.huge-executables">Why are compiled=
 executables so huge?!?</a></dt><dt>6.4. <a href=3D"faq.html#faq.programmin=
g.64bitporting">What do I have to look out for when porting applications to=
 64 bit Cygwin?</a></dt><dt>6.5. <a href=3D"faq.html#faq.programming.64bitp=
orting-fail">My project doesn't build at all on 64 bit Cygwin.  What's up?<=
/a></dt><dt>6.6. <a href=3D"faq.html#faq.programming.64bitporting-cygwin64"=
>Why is __CYGWIN64__ not defined for 64 bit?</a></dt><dt>6.7. <a href=3D"fa=
q.html#faq.programming.glibc">Where is glibc?</a></dt><dt>6.8. <a href=3D"f=
aq.html#faq.programming.objective-c">Where is Objective C?</a></dt><dt>6.9.=
 <a href=3D"faq.html#faq.programming.make-execvp">Why does my make fail on =
Cygwin with an execvp error? </a></dt><dt>6.10. <a href=3D"faq.html#faq.pro=
gramming.ipc">How can I use IPC, or why do I get a Bad system call
 error?</a></dt><dt>6.11. <a href=3D"faq.html#faq.programming.winmain">Why =
the undefined reference to WinMain@16?</a></dt><dt>6.12. <a href=3D"faq.htm=
l#faq.programming.win32-api">How do I use Win32 API calls?</a></dt><dt>6.13=
. <a href=3D"faq.html#faq.programming.win32-no-cygwin">How do I compile a W=
in32 executable that doesn't use Cygwin?</a></dt><dt>6.14. <a href=3D"faq.h=
tml#faq.programming.static-linking">Can I build a Cygwin program that does =
not require cygwin1.dll at runtime?</a></dt><dt>6.15. <a href=3D"faq.html#f=
aq.programming.msvcrt-and-cygwin">Can I link with both MSVCRT*.DLL and cygw=
in1.dll?</a></dt><dt>6.16. <a href=3D"faq.html#faq.programming.no-console-w=
indow">How do I make the console window go away?</a></dt><dt>6.17. <a href=
=3D"faq.html#faq.programming.make-spaces">Why does make complain about a "m=
issing separator"?</a></dt><dt>6.18. <a href=3D"faq.html#faq.programming.wi=
n32-headers">Why can't we redistribute Microsoft's Win32 headers?</a></dt><=
dt>6.19. <a href=3D"faq.html#faq.programming.msvs-mingw">How do I use cygwi=
n1.dll with Visual Studio or Mingw-w64?</a></dt><dt>6.20. <a href=3D"faq.ht=
ml#faq.programming.linking-lib">How do I link against a .lib file?</a></dt>=
<dt>6.21. <a href=3D"faq.html#faq.programming.building-cygwin">How do I bui=
ld Cygwin on my own?</a></dt><dt>6.22. <a href=3D"faq.html#faq.programming.=
debugging-cygwin">I may have found a bug in Cygwin, how can I debug it (the=
 symbols in gdb look funny)?</a></dt><dt>6.23. <a href=3D"faq.html#faq.prog=
ramming.compiling-unsupported">How can I compile Cygwin for an unsupported =
platform (PowerPC, Alpha, ARM, Itanium)?</a></dt><dt>6.24. <a href=3D"faq.h=
tml#faq.programming.adjusting-heap">How can I adjust the heap/stack size of=
 an application?</a></dt><dt>6.25. <a href=3D"faq.html#faq.programming.dll-=
cygcheck">How can I find out which DLLs are needed by an executable?</a></d=
t><dt>6.26. <a href=3D"faq.html#faq.programming.dll-building">How do I buil=
d a DLL?</a></dt><dt>6.27. <a href=3D"faq.html#faq.programming.breakpoint">=
How can I set a breakpoint at mainCRTStartup?</a></dt><dt>6.28. <a href=3D"=
faq.html#faq.programming.debug">How can I debug what's going on?</a></dt><d=
t>6.29. <a href=3D"faq.html#faq.programming.system-trace">Can I use a syste=
m trace mechanism instead?</a></dt><dt>6.30. <a href=3D"faq.html#faq.progra=
mming.gdb-signals">How does gdb handle signals?</a></dt><dt>6.31. <a href=
=3D"faq.html#faq.programming.linker">The linker complains that it can't fin=
d something.</a></dt><dt>6.32. <a href=3D"faq.html#faq.programming.stat64">=
Why do I get an error using struct stat64?</a></dt><dt>6.33. <a href=3D"faq=
.html#faq.programming.libc">Can you make DLLs that are linked against libc =
?</a></dt><dt>6.34. <a href=3D"faq.html#faq.programming.malloc-h">Where is =
malloc.h?</a></dt><dt>6.35. <a href=3D"faq.html#faq.programming.own-malloc"=
>Can I use my own malloc?</a></dt><dt>6.36. <a href=3D"faq.html#faq.program=
ming.msvc-gcc-objects">Can I mix objects compiled with msvc++ and gcc?</a><=
/dt><dt>6.37. <a href=3D"faq.html#faq.programming.gdb-msvc">Can I use the g=
db debugger to debug programs built by VC++?</a></dt><dt>6.38. <a href=3D"f=
aq.html#faq.programming.make-scripts">Shell scripts aren't running properly=
 from my makefiles?</a></dt><dt>6.39. <a href=3D"faq.html#faq.programming.p=
reprocessor">What preprocessor macros do I need to know about?</a></dt><dt>=
6.40. <a href=3D"faq.html#faq.programming.unix-gui">How should I port my Un=
ix GUI to Windows?</a></dt></dl></dd><dt>7.  <a href=3D"faq.html#faq.copyri=
ght">Copyright</a></dt><dd><dl><dt>7.1. <a href=3D"faq.html#faq.what.copyri=
ght">What are the copyrights?</a></dt></dl></dd></dl><table border=3D"0" st=
yle=3D"width: 100%;"><colgroup><col align=3D"left" width=3D"1%"><col></colg=
roup><tbody><tr class=3D"qandadiv"><td align=3D"left" valign=3D"top" colspa=
n=3D"2"><h3 class=3D"title"><a name=3D"faq.about"></a>1. About Cygwin</h3><=
/td></tr><tr class=3D"toc"><td align=3D"left" valign=3D"top" colspan=3D"2">=
<dl><dt>1.1. <a href=3D"faq.html#faq.what.what">What is it?</a></dt><dt>1.2=
. <a href=3D"faq.html#faq.what.supported">What versions of Windows are supp=
orted?</a></dt><dt>1.3. <a href=3D"faq.html#faq.what.where">Where can I get=
 it?</a></dt><dt>1.4. <a href=3D"faq.html#faq.what.free">Is it free softwar=
e?</a></dt><dt>1.5. <a href=3D"faq.html#faq.what.version">What version of C=
ygwin is this, anyway?</a></dt><dt>1.6. <a href=3D"faq.html#faq.what.who">W=
ho's behind the project?</a></dt></dl></td></tr><tr class=3D"question"><td =
align=3D"left" valign=3D"top"><a name=3D"faq.what.what"></a><p><b>1.1.</b><=
/p></td><td align=3D"left" valign=3D"top"><p>What is it?</p></td></tr><tr c=
lass=3D"answer"><td align=3D"left" valign=3D"top"></td><td align=3D"left" v=
align=3D"top"><p>Cygwin is a distribution of popular GNU and other Open Sou=
rce tools
 running on Microsoft Windows.  The core part is the Cygwin library which
 provides the POSIX system calls and environment these programs expect.
@@ -595,7 +595,7 @@ Can I bundle Cygwin with my product for free?
 </a></dt><dt>4.23. <a href=3D"faq.html#faq.using.older-cygwin-conflict">
 But doesn't that mean that if some application installs an older Cygwin
 DLL on top of a newer DLL, my application will break?
-</a></dt><dt>4.24. <a href=3D"faq.html#faq.using.missing-packages">Why isn=
't package XYZ available in Cygwin?</a></dt><dt>4.25. <a href=3D"faq.html#f=
aq.using.old-packages">Why is the Cygwin package of XYZ so out of date?</a>=
</dt><dt>4.26. <a href=3D"faq.html#faq.using.accessing-drives">How can I ac=
cess other drives?</a></dt><dt>4.27. <a href=3D"faq.html#faq.using.copy-and=
-paste">How can I copy and paste into Cygwin console windows?</a></dt><dt>4=
.28. <a href=3D"faq.html#faq.using.firewall">What firewall should I use wit=
h Cygwin? </a></dt><dt>4.29. <a href=3D"faq.html#faq.using.sharing-files">H=
ow can I share files between Unix and Windows?</a></dt><dt>4.30. <a href=3D=
"faq.html#faq.using.case-sensitive">Is Cygwin case-sensitive??</a></dt><dt>=
4.31. <a href=3D"faq.html#faq.using.dos-filenames">What about DOS special f=
ilenames?</a></dt><dt>4.32. <a href=3D"faq.html#faq.using.hangs">When it ha=
ngs, how do I get it back?</a></dt><dt>4.33. <a href=3D"faq.html#faq.using.=
directory-structure">Why the weird directory structure?</a></dt><dt>4.34. <=
a href=3D"faq.html#faq.using.anti-virus">How do anti-virus programs like Cy=
gwin?</a></dt><dt>4.35. <a href=3D"faq.html#faq.using.emacs">Is there a Cyg=
win port of GNU Emacs?</a></dt><dt>4.36. <a href=3D"faq.html#faq.using.xema=
cs">Is there a Cygwin port of XEmacs?</a></dt><dt>4.37. <a href=3D"faq.html=
#faq.using.symlinkstoppedworking">Why don't some of my old symlinks work an=
ymore?</a></dt><dt>4.38. <a href=3D"faq.html#faq.using.symlinks-samba">Why =
don't symlinks work on Samba-mounted filesystems?</a></dt><dt>4.39. <a href=
=3D"faq.html#faq.using.sshd-in-domain">How do I setup sshd in a domain?</a>=
</dt><dt>4.40. <a href=3D"faq.html#faq.using.ssh-pubkey-stops-working">Why =
does public key authentication with ssh fail after updating to Cygwin 1.7.3=
4 or later?</a></dt><dt>4.41. <a href=3D"faq.html#faq.using.same-with-rhost=
s">Why is my .rhosts file not recognized by rlogin anymore after updating t=
o Cygwin 1.7.34?</a></dt><dt>4.42. <a href=3D"faq.html#faq.using.same-with-=
permissions">Why do my files have extra permissions after updating to Cygwi=
n 1.7.34?</a></dt><dt>4.43. <a href=3D"faq.html#faq.using.tcl-tk">Why do my=
 Tk programs not work anymore?</a></dt><dt>4.44. <a href=3D"faq.html#faq.us=
ing.bloda">What applications have been found to interfere with Cygwin?</a><=
/dt><dt>4.45. <a href=3D"faq.html#faq.using.fixing-fork-failures">How do I =
fix fork() failures?</a></dt></dl></td></tr><tr class=3D"question"><td alig=
n=3D"left" valign=3D"top"><a name=3D"faq.using.missing-dlls"></a><p><b>4.1.=
</b></p></td><td align=3D"left" valign=3D"top"><p>Why can't my application =
locate cygncurses-8.dll?  or cygintl-3.dll?  or cygreadline6.dll?  or ...?<=
/p></td></tr><tr class=3D"answer"><td align=3D"left" valign=3D"top"></td><t=
d align=3D"left" valign=3D"top"><p>Well, something has gone wrong somehow...
+</a></dt><dt>4.24. <a href=3D"faq.html#faq.using.missing-packages">Why isn=
't package XYZ available in Cygwin?</a></dt><dt>4.25. <a href=3D"faq.html#f=
aq.using.old-packages">Why is the Cygwin package of XYZ so out of date?</a>=
</dt><dt>4.26. <a href=3D"faq.html#faq.using.accessing-drives">How can I ac=
cess other drives?</a></dt><dt>4.27. <a href=3D"faq.html#faq.using.copy-and=
-paste">How can I copy and paste into Cygwin console windows?</a></dt><dt>4=
.28. <a href=3D"faq.html#faq.using.firewall">What firewall should I use wit=
h Cygwin? </a></dt><dt>4.29. <a href=3D"faq.html#faq.using.sharing-files">H=
ow can I share files between Unix and Windows?</a></dt><dt>4.30. <a href=3D=
"faq.html#faq.using.case-sensitive">Is Cygwin case-sensitive??</a></dt><dt>=
4.31. <a href=3D"faq.html#faq.using.dos-filenames">What about DOS special f=
ilenames?</a></dt><dt>4.32. <a href=3D"faq.html#faq.using.hangs">When it ha=
ngs, how do I get it back?</a></dt><dt>4.33. <a href=3D"faq.html#faq.using.=
directory-structure">Why the weird directory structure?</a></dt><dt>4.34. <=
a href=3D"faq.html#faq.using.anti-virus">How do anti-virus programs like Cy=
gwin?</a></dt><dt>4.35. <a href=3D"faq.html#faq.using.emacs">Is there a Cyg=
win port of GNU Emacs?</a></dt><dt>4.36. <a href=3D"faq.html#faq.using.xema=
cs">Is there a Cygwin port of XEmacs?</a></dt><dt>4.37. <a href=3D"faq.html=
#faq.using.symlinkstoppedworking">Why don't some of my old symlinks work an=
ymore?</a></dt><dt>4.38. <a href=3D"faq.html#faq.using.symlinks-samba">Why =
don't symlinks work on Samba-mounted filesystems?</a></dt><dt>4.39. <a href=
=3D"faq.html#faq.using.sshd-in-domain">How do I setup sshd in a domain?</a>=
</dt><dt>4.40. <a href=3D"faq.html#faq.using.ssh-pubkey-stops-working">Why =
does public key authentication with ssh fail after updating to Cygwin 1.7.3=
4 or later?</a></dt><dt>4.41. <a href=3D"faq.html#faq.using.same-with-rhost=
s">Why is my .rhosts file not recognized by rlogin anymore after updating t=
o Cygwin 1.7.34?</a></dt><dt>4.42. <a href=3D"faq.html#faq.using.same-with-=
permissions">Why do my files have extra permissions after updating to Cygwi=
n 1.7.34?</a></dt><dt>4.43. <a href=3D"faq.html#faq.using.tcl-tk">Why do my=
 Tk programs not work anymore?</a></dt><dt>4.44. <a href=3D"faq.html#faq.us=
ing.bloda">What applications have been found to interfere with Cygwin?</a><=
/dt><dt>4.45. <a href=3D"faq.html#faq.using.fixing-fork-failures">How do I =
fix fork() failures?</a></dt><dt>4.46. <a href=3D"faq.html#faq.using.fixing=
-find_fast_cwd-warnings">How do I fix find_fast_cwd warnings?</a></dt></dl>=
</td></tr><tr class=3D"question"><td align=3D"left" valign=3D"top"><a name=
=3D"faq.using.missing-dlls"></a><p><b>4.1.</b></p></td><td align=3D"left" v=
align=3D"top"><p>Why can't my application locate cygncurses-8.dll?  or cygi=
ntl-3.dll?  or cygreadline6.dll?  or ...?</p></td></tr><tr class=3D"answer"=
><td align=3D"left" valign=3D"top"></td><td align=3D"left" valign=3D"top"><=
p>Well, something has gone wrong somehow...
 </p><p>To repair the damage, you must run Cygwin Setup again, and re-insta=
ll the
 package which provides the missing DLL package.
 </p><p>If you already installed the package at one point, Cygwin Setup won=
't
@@ -1376,7 +1376,28 @@ such as virtual memory paging and file caching.</p><=
/li></ul></div></td></tr><tr
       reappear.
       </p></li></ul></div><p>See the <a class=3D"ulink" href=3D"https://cy=
gwin.com/cygwin-ug-net/highlights.html#ov-hi-process" target=3D"_top">
   process creation</a> section of the User's Guide for the technical reaso=
ns it is so
-  difficult to make <code class=3D"literal">fork()</code> work reliably.</=
p></td></tr><tr class=3D"qandadiv"><td align=3D"left" valign=3D"top" colspa=
n=3D"2"><h3 class=3D"title"><a name=3D"faq.api"></a>5. Cygwin API Questions=
</h3></td></tr><tr class=3D"toc"><td align=3D"left" valign=3D"top" colspan=
=3D"2"><dl><dt>5.1. <a href=3D"faq.html#faq.api.everything">How does everyt=
hing work?</a></dt><dt>5.2. <a href=3D"faq.html#faq.api.snapshots">Are deve=
lopment snapshots for the Cygwin library available?</a></dt><dt>5.3. <a hre=
f=3D"faq.html#faq.api.cr-lf">How is the DOS/Unix CR/LF thing handled?</a></=
dt><dt>5.4. <a href=3D"faq.html#faq.api.threads">Is the Cygwin library mult=
i-thread-safe?</a></dt><dt>5.5. <a href=3D"faq.html#faq.api.fork">How is fo=
rk() implemented?</a></dt><dt>5.6. <a href=3D"faq.html#faq.api.globbing">Ho=
w does wildcarding (globbing) work?</a></dt><dt>5.7. <a href=3D"faq.html#fa=
q.api.symlinks">How do symbolic links work?</a></dt><dt>5.8. <a href=3D"faq=
.html#faq.api.executables">Why do some files, which are not executables hav=
e the 'x' type.</a></dt><dt>5.9. <a href=3D"faq.html#faq.api.secure">How se=
cure is Cygwin in a multi-user environment?</a></dt><dt>5.10. <a href=3D"fa=
q.html#faq.api.net-functions">How do the net-related functions work?</a></d=
t><dt>5.11. <a href=3D"faq.html#faq.api.winsock">I don't want Unix sockets,=
 how do I use normal Win32 winsock?</a></dt><dt>5.12. <a href=3D"faq.html#f=
aq.api.versions">What version numbers are associated with Cygwin?</a></dt><=
dt>5.13. <a href=3D"faq.html#faq.api.timezone">Why isn't timezone set corre=
ctly?</a></dt><dt>5.14. <a href=3D"faq.html#faq.api.mouse">Is there a mouse=
 interface?</a></dt></dl></td></tr><tr class=3D"question"><td align=3D"left=
" valign=3D"top"><a name=3D"faq.api.everything"></a><p><b>5.1.</b></p></td>=
<td align=3D"left" valign=3D"top"><p>How does everything work?</p></td></tr=
><tr class=3D"answer"><td align=3D"left" valign=3D"top"></td><td align=3D"l=
eft" valign=3D"top"><p>There's a C library which provides a POSIX-style API=
.  The
+  difficult to make <code class=3D"literal">fork()</code> work reliably.</=
p></li></ul></div></td></tr><tr class=3D"question"><td align=3D"left" valig=
n=3D"top"><a name=3D"faq.using.fixing-find_fast_cwd-warnings"></a><p><b>4.4=
6.</b></p></td><td align=3D"left" valign=3D"top"><p>How do I fix <code clas=
s=3D"literal">find_fast_cwd</code> warnings?</p></td></tr><tr class=3D"answ=
er"><td align=3D"left" valign=3D"top"></td><td align=3D"left" valign=3D"top=
"><p>Some ancient Cygwin releases asked users to report problems that were =
difficult
+to diagnose to the mailing list with the message:</p><p>
+<blockquote>find_fast_cwd: WARNING: Couldn't compute FAST_CWD pointer. Ple=
ase report
+    this problem to the public mailing list cygwin@cygwin.com</blockquote>=
<p>
+These problems were fixed long ago in updated Cygwin releases.</p><p>
+Unfortunately some projects and products still distribute these ancient Cy=
gwin
+releases, which do not support newer Windows releases, rather than having =
their
+product install the current Cygwin release over the Internet.
+They also provide no information about keeping Cygwin up to date with upgr=
ades
+and fixes.</p><p>
+The fix is simply downloading and running Cygwin Setup, using the instruct=
ions at:=20
+<a class=3D"ulink" href=3D"https://cygwin.com/cygwin-ug-net/setup-net.html=
" target=3D"_top">https://cygwin.com/cygwin-ug-net/setup-net.html</a>.</p><=
p>
+When running Setup, you should not change most of the values presented, ju=
st
+select the <strong>Next</strong> button in most cases, as you already have=
 a
+Cygwin release installed and only want to upgrade your current installatio=
n.
+You should make your own selection if the internet connection to your syst=
em
+requires a proxy, and to pick the nearest up to date Cygwin download (mirr=
or)
+site to your system for faster downloads.</p><p>
+Cygwin Setup will download and apply updates to all packages required for
+Cygwin itself and installed applications.
+Any problems with applying updates or the application after updates should=
 be
+reported to the project or product vendor for follow up action.</p></td></=
tr><tr class=3D"qandadiv"><td align=3D"left" valign=3D"top" colspan=3D"2"><=
h3 class=3D"title"><a name=3D"faq.api"></a>5. Cygwin API Questions</h3></td=
></tr><tr class=3D"toc"><td align=3D"left" valign=3D"top" colspan=3D"2"><dl=
><dt>5.1. <a href=3D"faq.html#faq.api.everything">How does everything work?=
</a></dt><dt>5.2. <a href=3D"faq.html#faq.api.snapshots">Are development sn=
apshots for the Cygwin library available?</a></dt><dt>5.3. <a href=3D"faq.h=
tml#faq.api.cr-lf">How is the DOS/Unix CR/LF thing handled?</a></dt><dt>5.4=
. <a href=3D"faq.html#faq.api.threads">Is the Cygwin library multi-thread-s=
afe?</a></dt><dt>5.5. <a href=3D"faq.html#faq.api.fork">How is fork() imple=
mented?</a></dt><dt>5.6. <a href=3D"faq.html#faq.api.globbing">How does wil=
dcarding (globbing) work?</a></dt><dt>5.7. <a href=3D"faq.html#faq.api.syml=
inks">How do symbolic links work?</a></dt><dt>5.8. <a href=3D"faq.html#faq.=
api.executables">Why do some files, which are not executables have the 'x' =
type.</a></dt><dt>5.9. <a href=3D"faq.html#faq.api.secure">How secure is Cy=
gwin in a multi-user environment?</a></dt><dt>5.10. <a href=3D"faq.html#faq=
.api.net-functions">How do the net-related functions work?</a></dt><dt>5.11=
. <a href=3D"faq.html#faq.api.winsock">I don't want Unix sockets, how do I =
use normal Win32 winsock?</a></dt><dt>5.12. <a href=3D"faq.html#faq.api.ver=
sions">What version numbers are associated with Cygwin?</a></dt><dt>5.13. <=
a href=3D"faq.html#faq.api.timezone">Why isn't timezone set correctly?</a><=
/dt><dt>5.14. <a href=3D"faq.html#faq.api.mouse">Is there a mouse interface=
?</a></dt></dl></td></tr><tr class=3D"question"><td align=3D"left" valign=
=3D"top"><a name=3D"faq.api.everything"></a><p><b>5.1.</b></p></td><td alig=
n=3D"left" valign=3D"top"><p>How does everything work?</p></td></tr><tr cla=
ss=3D"answer"><td align=3D"left" valign=3D"top"></td><td align=3D"left" val=
ign=3D"top"><p>There's a C library which provides a POSIX-style API.  The
 applications are linked with it and voila - they run on Windows.
 </p><p>The aim is to add all the goop necessary to make your apps run on
 Windows into the C library.  Then your apps should (ideally) run on POSIX
--=20
2.15.0


--------------2F57CFE5CEEC5D11625C6829--
