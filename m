Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id 14D953857000
 for <cygwin-patches@cygwin.com>; Tue,  1 Dec 2020 09:18:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 14D953857000
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MS4WT-1kdFLc0Uzj-00TUF2 for <cygwin-patches@cygwin.com>; Tue, 01 Dec 2020
 10:18:35 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 8A493A80706; Tue,  1 Dec 2020 10:18:33 +0100 (CET)
Date: Tue, 1 Dec 2020 10:18:33 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Use automake (v3)
Message-ID: <20201201091833.GJ303847@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201124133720.45823-1-jon.turney@dronecode.org.uk>
 <20201130102524.GC303847@calimero.vinschen.de>
 <20201130104718.GD303847@calimero.vinschen.de>
 <6fa43a94-c29d-fa48-07d0-1ef095d9f5e3@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <6fa43a94-c29d-fa48-07d0-1ef095d9f5e3@dronecode.org.uk>
X-Provags-ID: V03:K1:qqH+BmgBkZUcztlsU5btfDZ+PqthK32qrOuOHq4kXyuoV43m+zx
 uwabw00vP38REQkG1ZqQHPipziMATiqJcuaTFEa64tU4vUREMPqqFshKjkCjmnH4T3p96N0
 Sux/JrwPshrOdZCt4BIwmW0EKWC7+wTCBGVGesrLSgLfpXqORe9tm+BBlhGaf7u4nBnmYZo
 UCzJrC0zHaPJSHf5+OpAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BIEembvKnfI=:RyOEzGihYyuQv0wkcKni9n
 WhsDmnn5C3RXc4OpNPIM4e7AnIjzGA8e/WNYn3eDzoG7QuBw5s8rddkK6Za0zpJZurQdT/Gm+
 9D25fHpwf01qQw5ikFR4E7p463AQXLSQ23V6D65szoM9vGyl4/NiuHxhR70iA0fl3xe3AvPwM
 PBxYry5w4qt43cVmBrsQzE0jJIT5Hp0txRCmKDPhIZwFnO4FE8EHg4NzTOxU0dvlf7iRAVsP8
 4vbEx5EGYVnofNXtHn5dealuuDmwn8h1F238Xe2NUbpF/KnmowEi4v0DRVrYfAAiqN+ENFZlb
 l4uK/+wALADJYUeE4Ge0so7WxOYhAJufGRENcI/3kClJoQOICjbuIGkNsVCflHUEp1G8qgEwZ
 kg4d+vpMT66UqaI6rro0zEImDIO5iODLKFplY5kuKx5BFOKJTK5t4KcLnQG0qPENzmnmNrOQV
 XQg6MXK1AA==
X-Spam-Status: No, score=-106.9 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 01 Dec 2020 09:18:41 -0000


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Jon,

On Nov 30 17:02, Jon Turney wrote:
> On 30/11/2020 10:47, Corinna Vinschen wrote:
> > On Nov 30 11:25, Corinna Vinschen wrote:
> > 
> > Also, after applying the patch and autogen-ing, a full build from
> > top-level fails with some warnings and a final undefined symbol:
> 
> The warnings are expected at this stage.
> 
> > make[5]: Entering directory '[...]/x86_64-pc-cygwin/winsup/utils/mingw'
> >    CXX      ../bloda.o
> >    CXX      ../cygcheck.o
> >    CXX      ../dump_setup.o
> >    CXX      ../ldh.o
> >    CXX      ../path.o
> >    CXX      ../cygwin-console-helper.o
> >    CXX      ../path_testsuite-path.o
> >    CXX      ../strace.o
> >    CXX      ../path_testsuite-testsuite.o
> > [...]/winsup/utils/mingw/../testsuite.cc:18: warning: "TESTSUITE" redefined
> >     18 | #define TESTSUITE
> 
> This redefinition should probably be inside #ifndef TESTSUITE/#endif
> 
> > <command-line>: note: this is the location of the previous definition
> >    CXXLD    cygwin-console-helper.exe
> >    CXXLD    ldh.exe
> > In file included from [...]/winsup/utils/mingw/../path.cc:263:
> > [...]/winsup/utils/mingw/../testsuite.h:22:24: warning: ISO C++ forbids converting a string constant to 'char*' [-Wwrite-strings]
> >     22 | #define TESTSUITE_ROOT "X:\\xyzroot"
> 
> I'm not sure how to restructure things to avoid this warning.
> 
> The '-Wno-error=write-strings' flag is added when building this test to
> avoid this being fatal.
> 
> >    CXXLD    path-testsuite.exe
> > /usr/lib/gcc/x86_64-w64-mingw32/9.2.1/../../../../x86_64-w64-mingw32/bin/ld: ../path_testsuite-path.o:path.cc:(.rdata$.refptr.max_mount_entry[.refptr.max_mount_entry]+0x0): undefined reference to `max_mount_entry'
> 
> This is a bit puzzling.  I don't get this when building locally, but idk why
> since there is only a tentative definition of this variable.
> 
> I'm not sure how this being built is changed by automaking to stop it
> working for you (perhaps optimization flags are now being used?)
> 
> Perhaps the attached helps, although what is getting stubbed out when
> testing could be clearer.

It helps to build the whole lot.  The warnings are still generated.
I applied the attached patch to avoid the warnings when building
path-testsuite.exe.  Still TODO are the warnings generated when 
building libltp, though.

What bugs me is that the mingw executables are built in utils/mingw,
but the object files are still in utils.  Any problem generating the
object files in utils/mingw, too?


Thanks,
Corinna

--ibTvN161/egqYuK8
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-Cygwin-fix-remaining-warnings-building-path-testsuit.patch"

From d9445d0fcbea11a9240141a5234b3ff5f0de5f63 Mon Sep 17 00:00:00 2001
From: Corinna Vinschen <corinna@vinschen.de>
Date: Tue, 1 Dec 2020 10:10:40 +0100
Subject: [PATCH] Cygwin: fix remaining warnings building path-testsuite.exe

---
 winsup/utils/path.cc      |  6 ++----
 winsup/utils/testsuite.cc |  2 ++
 winsup/utils/testsuite.h  | 12 ++++++------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/winsup/utils/path.cc b/winsup/utils/path.cc
index 4c1bb4029da5..29344be02033 100644
--- a/winsup/utils/path.cc
+++ b/winsup/utils/path.cc
@@ -559,6 +559,7 @@ from_fstab (bool user, PWCHAR path, PWCHAR path_end)
 
 #ifndef FSTAB_ONLY
 
+#ifndef TESTSUITE
 static int
 mnt_sort (const void *a, const void *b)
 {
@@ -580,9 +581,6 @@ extern "C" WCHAR cygwin_dll_path[];
 static void
 read_mounts ()
 {
-/* If TESTSUITE is defined, bypass this whole function as a harness
-   mount table will be provided.  */
-#ifndef TESTSUITE
   HKEY setup_key;
   LONG ret;
   DWORD len;
@@ -654,8 +652,8 @@ read_mounts ()
   from_fstab (false, path, path_end);
   from_fstab (true, path, path_end);
   qsort (mount_table, max_mount_entry, sizeof (mnt_t), mnt_sort);
-#endif /* !defined(TESTSUITE) */
 }
+#endif /* !defined(TESTSUITE) */
 
 /* Return non-zero if PATH1 is a prefix of PATH2.
    Both are assumed to be of the same path style and / vs \ usage.
diff --git a/winsup/utils/testsuite.cc b/winsup/utils/testsuite.cc
index c0a800b01e86..23ed8e0d81c0 100644
--- a/winsup/utils/testsuite.cc
+++ b/winsup/utils/testsuite.cc
@@ -15,7 +15,9 @@ details. */
 #include <unistd.h>
 #define WIN32_LEAN_AND_MEAN
 #include <windows.h>
+#ifndef TESTSUITE
 #define TESTSUITE
+#endif
 #include "testsuite.h"
 
 typedef struct
diff --git a/winsup/utils/testsuite.h b/winsup/utils/testsuite.h
index d0a47b23aa9f..0dd6315398de 100644
--- a/winsup/utils/testsuite.h
+++ b/winsup/utils/testsuite.h
@@ -30,12 +30,12 @@ details. */
 #if defined(TESTSUITE_MOUNT_TABLE)
 static mnt_t mount_table[] = {
 /* native                 posix               flags */
- { TESTSUITE_ROOT,        (char*)"/",                MOUNT_SYSTEM},
- { "O:\\other",           (char*)"/otherdir",        MOUNT_SYSTEM},
- { "S:\\some\\dir",       (char*)"/somedir",         MOUNT_SYSTEM},
- { TESTSUITE_ROOT"\\bin", (char*)"/usr/bin",         MOUNT_SYSTEM},
- { TESTSUITE_ROOT"\\lib", (char*)"/usr/lib",         MOUNT_SYSTEM},
- { ".",                   (char*)TESTSUITE_CYGDRIVE, MOUNT_SYSTEM | MOUNT_CYGDRIVE},
+ { (char*)TESTSUITE_ROOT,        (char*)"/",                MOUNT_SYSTEM},
+ { (char*)"O:\\other",           (char*)"/otherdir",        MOUNT_SYSTEM},
+ { (char*)"S:\\some\\dir",       (char*)"/somedir",         MOUNT_SYSTEM},
+ { (char*)TESTSUITE_ROOT"\\bin", (char*)"/usr/bin",         MOUNT_SYSTEM},
+ { (char*)TESTSUITE_ROOT"\\lib", (char*)"/usr/lib",         MOUNT_SYSTEM},
+ { (char*)".",                   (char*)TESTSUITE_CYGDRIVE, MOUNT_SYSTEM | MOUNT_CYGDRIVE},
  { NULL,                  (char*)NULL,               0}
 };
 
-- 
2.26.2


--ibTvN161/egqYuK8--
