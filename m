Return-Path: <cygwin-patches-return-6129-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30733 invoked by alias); 2 Aug 2007 23:04:13 -0000
Received: (qmail 30715 invoked by uid 22791); 2 Aug 2007 23:04:13 -0000
X-Spam-Check-By: sourceware.org
Received: from mail.artimi.com (HELO mail.artimi.com) (194.72.81.2)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 02 Aug 2007 23:04:08 +0000
Received: from rainbow ([192.168.8.46]) by mail.artimi.com with Microsoft SMTPSVC(6.0.3790.3959); 	 Fri, 3 Aug 2007 00:04:04 +0100
From: "Dave Korn" <dave.korn@artimi.com>
To: <cygwin-patches@cygwin.com>
Subject: [PATCH] Updated: Big List Of Dodgy Apps for cygcheck.
Date: Thu, 02 Aug 2007 23:04:00 -0000
Message-ID: <034801c7d559$6c039c10$2e08a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: multipart/mixed; 	boundary="----=_NextPart_000_0349_01C7D561.CDC80410"
X-Mailer: Microsoft Office Outlook 11
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q3/txt/msg00004.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0349_01C7D561.CDC80410
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Content-length: 782



  As it turned out, the w32api/ddk header files already included the struct
definition I needed, only under a different name, so I reworked the patch to
drop the ntdll.h changes and use the w32api ddk headers instead.  I think I
got rid of all the misaligned k'n'r style braces as well.



winsup/utils/ChangeLog

2007-08-02  Dave Korn  <dave.korn@artimi.com>

	* Makefile.in (cygcheck.exe):  Add bloda.o as prerequisite, adjusting
	dependency-filtering $(wordlist ...) call appropriately.  Link ntdll.
	(bloda.o):  New rule to build bloda.o
	* cygcheck.cc (dump_sysinfo):  Call bloda function dump_dodgy_apps().
	* bloda.cc:  New file implements detection of applications from the
	Big List Of Dodgy Apps.



    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....

------=_NextPart_000_0349_01C7D561.CDC80410
Content-Type: application/octet-stream;
	name="cygcheck-bloda-patch.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cygcheck-bloda-patch.diff"
Content-length: 19239

Index: winsup/utils/Makefile.in=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/utils/Makefile.in,v=0A=
retrieving revision 1.66=0A=
diff -p -u -r1.66 Makefile.in=0A=
--- winsup/utils/Makefile.in	10 Jul 2007 00:12:54 -0000	1.66=0A=
+++ winsup/utils/Makefile.in	2 Aug 2007 23:01:04 -0000=0A=
@@ -1,6 +1,6 @@=0A=
 # Makefile for Cygwin utilities=0A=
 # Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004,=0A=
-# 2005, 2006 Red Hat, Inc.=0A=
+# 2005, 2006, 2007 Red Hat, Inc.=0A=
=20=0A=
 # This file is part of Cygwin.=0A=
=20=0A=
@@ -99,15 +99,15 @@ else=0A=
 	$(CXX) $(MINGW_CXXFLAGS) -o $@ ${wordlist 1,2,$^} -B$(mingw_build)/ $(MIN=
GW_LDFLAGS)=0A=
 endif=0A=
=20=0A=
-cygcheck.exe: cygcheck.o path.o dump_setup.o $(MINGW_DEP_LDLIBS)=0A=
+cygcheck.exe: cygcheck.o bloda.o path.o dump_setup.o $(MINGW_DEP_LDLIBS)=
=0A=
 ifeq "$(libz)" ""=0A=
 	@echo '*** Building cygcheck without package content checking due to miss=
ing mingw libz.a.'=0A=
 endif=0A=
 ifdef VERBOSE=0A=
-	$(CXX) $(MINGW_CXXFLAGS) -o $@ ${wordlist 1,3,$^} -B$(mingw_build)/ $(MIN=
GW_LDFLAGS) $(libz)=0A=
+	$(CXX) $(MINGW_CXXFLAGS) -o $@ ${wordlist 1,4,$^} -B$(mingw_build)/ $(MIN=
GW_LDFLAGS) $(libz) -lntdll=0A=
 else=0A=
-	@echo $(CXX) -o $@ ${wordlist 1,3,$^} ${filter-out -B%, $(MINGW_CXXFLAGS)=
 $(MINGW_LDFLAGS)} $(libz);\=0A=
-	$(CXX) $(MINGW_CXXFLAGS) -o $@ ${wordlist 1,3,$^} -B$(mingw_build)/ $(MIN=
GW_LDFLAGS) $(libz)=0A=
+	@echo $(CXX) -o $@ ${wordlist 1,4,$^} ${filter-out -B%, $(MINGW_CXXFLAGS)=
 $(MINGW_LDFLAGS)} $(libz) -lntdll;\=0A=
+	$(CXX) $(MINGW_CXXFLAGS) -o $@ ${wordlist 1,4,$^} -B$(mingw_build)/ $(MIN=
GW_LDFLAGS) $(libz) -lntdll=0A=
 endif=0A=
=20=0A=
 dumper.o: dumper.cc dumper.h=0A=
@@ -150,6 +150,14 @@ else=0A=
 	$(MINGW_CXX) $(zconf_h) $(zlib_h) $c -o $(@D)/$(basename $@)$o $(MINGW_CX=
XFLAGS) $<=0A=
 endif=0A=
=20=0A=
+bloda.o: bloda.cc=0A=
+ifdef VERBOSE=0A=
+	${MINGW_CXX} $c -o $(@D)/$(basename $@)$o $(MINGW_CXXFLAGS) -I$(updir) $<=
=0A=
+else=0A=
+	@echo $(MINGW_CXX) $c -o $(@D)/$(basename $@)$o $(MINGW_CXXFLAGS) ... $^;=
\=0A=
+	${MINGW_CXX} $c -o $(@D)/$(basename $@)$o $(MINGW_CXXFLAGS) -I$(updir) $<=
=0A=
+endif=0A=
+=0A=
 cygcheck.o: cygcheck.cc=0A=
 ifdef VERBOSE=0A=
 	${MINGW_CXX} $c -o $(@D)/$(basename $@)$o $(MINGW_CXXFLAGS) -I$(updir) $<=
=0A=
Index: winsup/utils/bloda.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: winsup/utils/bloda.cc=0A=
diff -N winsup/utils/bloda.cc=0A=
--- /dev/null	1 Jan 1970 00:00:00 -0000=0A=
+++ winsup/utils/bloda.cc	2 Aug 2007 23:01:04 -0000=0A=
@@ -0,0 +1,410 @@=0A=
+/* bloda.cc=0A=
+=0A=
+   Copyright 2007 Red Hat, Inc.=0A=
+=0A=
+   This file is part of Cygwin.=0A=
+=0A=
+   This software is a copyrighted work licensed under the terms of the=0A=
+   Cygwin license.  Please consult the file "CYGWIN_LICENSE" for=0A=
+   details. */=0A=
+=0A=
+#define cygwin_internal cygwin_internal_dontuse=0A=
+#include <stdio.h>=0A=
+#include <assert.h>=0A=
+#include <windows.h>=0A=
+#include <ntdef.h>=0A=
+#include <ddk/ntstatus.h>=0A=
+#include <ddk/ntapi.h>=0A=
+#undef cygwin_internal=0A=
+=0A=
+#undef DEBUGGING=0A=
+#ifdef DEBUGGING=0A=
+#define dbg_printf(ARGS) printf ARGS ; fflush (NULL)=0A=
+#else  /* !DEBUGGING */=0A=
+#define dbg_printf(ARGS) do { } while (0)=0A=
+#endif /* ?DEBUGGING */=0A=
+=0A=
+/*  This module detects applications from the Big List of Dodgy Apps,=0A=
+  a list of applications that have at some given time been shown to=0A=
+  interfere with the operation of cygwin.  It detects the presence of=0A=
+  applications on the system by looking for any of four traces an=0A=
+  installation might leave: 1) registry keys, 2) files on disk=0A=
+  3) running executables 4) loaded dlls or drivers.=0A=
+=0A=
+  At the time of writing, the BLODA amounts to:-=0A=
+=0A=
+    Sonic Solutions burning software containing DLA component=0A=
+    Norton/MacAffee/Symantec antivirus or antispyware=0A=
+    Logitech webcam software with "Logitech process monitor" service=0A=
+    Kerio, Agnitum or ZoneAlarm Personal Firewall=0A=
+    Iolo System Mechanic/AntiVirus/Firewall=0A=
+    LanDesk=0A=
+    Windows Defender=20=0A=
+    Embassy Trust Suite fingerprint reader software containing wxvault.dll=
=0A=
+*/=0A=
+=0A=
+enum bad_app=0A=
+{=0A=
+  SONIC,    NORTON,  MACAFFEE,    SYMANTEC,=0A=
+  LOGITECH, KERIO,   AGNITUM,     ZONEALARM,=0A=
+  IOLO,     LANDESK, WINDEFENDER, EMBASSYTS=0A=
+};=0A=
+=0A=
+struct bad_app_info=0A=
+{=0A=
+  enum bad_app app_id;=0A=
+  const char *details;=0A=
+  char found_it;=0A=
+};=0A=
+=0A=
+enum bad_app_det_method=0A=
+{=0A=
+  HKLMKEY, HKCUKEY, FILENAME, PROCESSNAME, HOOKDLLNAME=0A=
+};=0A=
+=0A=
+struct bad_app_det=0A=
+{=0A=
+  enum bad_app_det_method type;=0A=
+  const char *param;=0A=
+  enum bad_app app;=0A=
+};=0A=
+=0A=
+static const struct bad_app_det dodgy_app_detects[] =3D=0A=
+{=0A=
+  { PROCESSNAME, "dlactrlw.exe",                                          =
       SONIC      },=0A=
+  { HOOKDLLNAME, "wxvault.dll",                                           =
       EMBASSYTS  },=0A=
+  { HKLMKEY,     "SYSTEM\\CurrentControlSet\\Services\\vsdatant",         =
       ZONEALARM  },=0A=
+  { FILENAME,    "%windir%\\System32\\vsdatant.sys",                      =
       ZONEALARM  },=0A=
+  { HKLMKEY,     "SYSTEM\\CurrentControlSet\\Services\\lvprcsrv",         =
       LOGITECH   },=0A=
+  { PROCESSNAME, "LVPrcSrv.exe",                                          =
       LOGITECH   },=0A=
+  { FILENAME,    "%programfiles%\\common files\\logitech\\lvmvfm\\LVPrcSrv=
.exe", LOGITECH   },=0A=
+};=20=0A=
+=0A=
+static const size_t num_of_detects =3D sizeof (dodgy_app_detects) / sizeof=
 (dodgy_app_detects[0]);=0A=
+=0A=
+static struct bad_app_info big_list_of_dodgy_apps[] =3D=0A=
+{=0A=
+  { SONIC,       "Sonic Solutions burning software containing DLA componen=
t"              },=0A=
+  { NORTON,      "Norton antivirus or antispyware software"               =
                },=0A=
+  { MACAFFEE,    "Macaffee antivirus or antispyware software"             =
                },=0A=
+  { SYMANTEC,    "Symantec antivirus or antispyware software"             =
                },=0A=
+  { LOGITECH,    "Logitech Process Monitor service"                       =
                },=0A=
+  { KERIO,       "Kerio Personal Firewall"                                =
                },=0A=
+  { AGNITUM,     "Agnitum Personal Firewall"                              =
                },=0A=
+  { ZONEALARM,   "ZoneAlarm Personal Firewall"                            =
                },=0A=
+  { IOLO,        "Iolo System Mechanic/AntiVirus/Firewall software"       =
                },=0A=
+  { LANDESK,     "Landesk"                                                =
                },=0A=
+  { WINDEFENDER, "Windows Defender"                                       =
                },=0A=
+  { EMBASSYTS,   "Embassy Trust Suite fingerprint reader software containi=
ng wxvault.dll" },=0A=
+};=0A=
+=0A=
+static const size_t num_of_dodgy_apps =3D sizeof (big_list_of_dodgy_apps) =
/ sizeof (big_list_of_dodgy_apps[0]);=0A=
+=0A=
+/* This function is not in the ntdll export lib, so it has=0A=
+  to be looked up at runtime and called through a pointer.  */=0A=
+VOID NTAPI (*pRtlFreeUnicodeString)(PUNICODE_STRING) =3D NULL;=0A=
+=0A=
+static PSYSTEM_PROCESSES=0A=
+get_process_list (void)=0A=
+{=0A=
+  int n_procs =3D 0x100;=0A=
+  PSYSTEM_PROCESSES pslist =3D (PSYSTEM_PROCESSES) malloc (n_procs * sizeo=
f *pslist);=0A=
+=0A=
+  while (NtQuerySystemInformation (SystemProcessesAndThreadsInformation,=
=0A=
+    pslist, n_procs * sizeof *pslist, 0) =3D=3D STATUS_INFO_LENGTH_MISMATC=
H)=0A=
+    {=0A=
+      n_procs *=3D 2;=0A=
+      free (pslist);=0A=
+      pslist =3D (PSYSTEM_PROCESSES) malloc (n_procs * sizeof *pslist);=0A=
+    }=0A=
+  return pslist;=0A=
+}=0A=
+=0A=
+static PSYSTEM_MODULE_INFORMATION=0A=
+get_module_list (void)=0A=
+{=0A=
+  int modsize =3D 0x1000;=0A=
+  PSYSTEM_MODULE_INFORMATION modlist =3D (PSYSTEM_MODULE_INFORMATION) mall=
oc (modsize);=0A=
+=0A=
+  while (NtQuerySystemInformation (SystemModuleInformation,=0A=
+    modlist, modsize, NULL) =3D=3D STATUS_INFO_LENGTH_MISMATCH)=0A=
+    {=0A=
+      modsize *=3D 2;=0A=
+      free (modlist);=0A=
+      modlist =3D (PSYSTEM_MODULE_INFORMATION) malloc (modsize);=0A=
+    }=0A=
+  return modlist;=0A=
+}=0A=
+=0A=
+static bool=0A=
+find_process_in_list (PSYSTEM_PROCESSES pslist, PUNICODE_STRING psname)=0A=
+{=0A=
+  while (1)=0A=
+    {=0A=
+      if (pslist->ProcessName.Length && pslist->ProcessName.Buffer)=0A=
+        {=0A=
+          dbg_printf (("%S\n", pslist->ProcessName.Buffer));=0A=
+          if (!_wcsicmp (pslist->ProcessName.Buffer, psname->Buffer))=0A=
+            return true;=0A=
+        }=0A=
+      if (!pslist->NextEntryDelta)=0A=
+        break;=0A=
+      pslist =3D (PSYSTEM_PROCESSES)(pslist->NextEntryDelta + (char *)psli=
st);=0A=
+    };=0A=
+  return false;=0A=
+}=0A=
+=0A=
+static bool=0A=
+find_module_in_list (PSYSTEM_MODULE_INFORMATION modlist, const char * cons=
t modname)=0A=
+{=0A=
+  PSYSTEM_MODULE_INFORMATION_ENTRY modptr =3D &modlist->Module[0];=0A=
+  DWORD count =3D modlist->Count;=0A=
+  while (count--)=0A=
+    {=0A=
+      dbg_printf (("name '%s' offset %d ", &modptr->ImageName[0], modptr->=
PathLength));=0A=
+      dbg_printf (("=3D '%s'\n", &modptr->ImageName[modptr->PathLength]));=
=0A=
+      if (!_stricmp (&modptr->ImageName[modptr->PathLength], modname))=0A=
+        return true;=0A=
+      modptr++;=0A=
+    }=0A=
+  return false;=0A=
+}=0A=
+=0A=
+static bool=0A=
+expand_path (const char *path, char *outbuf)=0A=
+{=0A=
+  char *dst =3D outbuf;=0A=
+  const char *end, *envval;=0A=
+  char envvar[MAX_PATH];=0A=
+  size_t len;=0A=
+=0A=
+  while ((dst - outbuf) < MAX_PATH)=0A=
+    {=0A=
+      if (*path !=3D '%')=0A=
+        {=0A=
+          if ((*dst++ =3D *path++) !=3D 0)=0A=
+            continue;=0A=
+          break;=0A=
+        }=0A=
+      /* Expand an environ var.  */=0A=
+      end =3D path + 1;=0A=
+      while (*end !=3D '%')=0A=
+        {=0A=
+          /* Watch out for unterminated %  */=0A=
+          if (*end++ =3D=3D 0)=0A=
+            {=0A=
+              end =3D NULL;=0A=
+              break;=0A=
+            }=0A=
+        }=0A=
+      /* If we didn't find the end, can't expand it.  */=0A=
+      if ((end =3D=3D NULL) || (end =3D=3D (path + 1)))=0A=
+        {=0A=
+          /* Unterminated % so copy verbatim.  */=0A=
+          *dst++ =3D *path++;=0A=
+          continue;=0A=
+        }=0A=
+      /* Expand the environment var into the new path.  */=0A=
+      if ((end - (path + 1)) >=3D MAX_PATH)=0A=
+        return -1;=0A=
+      memcpy (envvar, path + 1, end - (path + 1));=0A=
+      envvar[end - (path + 1)] =3D 0;=0A=
+      envval =3D getenv (envvar);=0A=
+      /* If not found, copy env var name verbatim.  */=0A=
+      if (envval =3D=3D NULL)=0A=
+        {=0A=
+          *dst++ =3D *path++;=0A=
+          continue;=0A=
+        }=0A=
+      /* Check enough room before copying.  */=0A=
+      len =3D strlen (envval);=0A=
+      if ((dst + len - outbuf) >=3D MAX_PATH)=0A=
+        return false;=0A=
+      memcpy (dst, envval, len);=0A=
+      dst +=3D len;=0A=
+      /* And carry on past the end of env var name.  */=0A=
+      path =3D end + 1;=0A=
+    }=0A=
+  return (dst - outbuf) < MAX_PATH;=0A=
+}=0A=
+=0A=
+static bool=20=0A=
+detect_dodgy_app (const struct bad_app_det *det, PSYSTEM_PROCESSES pslist,=
 PSYSTEM_MODULE_INFORMATION modlist)=0A=
+{=0A=
+  HANDLE fh;=0A=
+  HKEY hk;=0A=
+  UNICODE_STRING unicodename;=0A=
+  ANSI_STRING ansiname;=0A=
+  NTSTATUS rv;=0A=
+  bool found;=0A=
+  char expandedname[MAX_PATH];=0A=
+=0A=
+  switch (det->type)=0A=
+    {=0A=
+    case HKLMKEY:=0A=
+      dbg_printf (("Detect reg key hklm '%s'... ", det->param));=0A=
+      if (RegOpenKeyEx (HKEY_LOCAL_MACHINE, det->param, 0, STANDARD_RIGHTS=
_READ, &hk) =3D=3D ERROR_SUCCESS)=0A=
+        {=0A=
+          RegCloseKey (hk);=0A=
+          dbg_printf (("found!\n"));=0A=
+          return true;=0A=
+        }=0A=
+      break;=0A=
+=0A=
+    case HKCUKEY:=0A=
+      dbg_printf (("Detect reg key hkcu '%s'... ", det->param));=0A=
+      if (RegOpenKeyEx (HKEY_CURRENT_USER, det->param, 0, STANDARD_RIGHTS_=
READ, &hk) =3D=3D ERROR_SUCCESS)=0A=
+        {=0A=
+          RegCloseKey (hk);=0A=
+          dbg_printf (("found!\n"));=0A=
+          return true;=0A=
+        }=0A=
+      break;=0A=
+=0A=
+    case FILENAME:=0A=
+      dbg_printf (("Detect filename '%s'... ", det->param));=0A=
+      if (!expand_path (det->param, expandedname))=0A=
+        {=0A=
+          printf ("Expansion failure!\n");=0A=
+          break;=0A=
+        }=0A=
+      dbg_printf (("('%s' after expansion)... ", expandedname));=0A=
+      fh =3D CreateFile (expandedname, 0, FILE_SHARE_READ | FILE_SHARE_WRI=
TE=0A=
+        | FILE_SHARE_DELETE, NULL, OPEN_EXISTING, 0, NULL);=0A=
+      if (fh !=3D INVALID_HANDLE_VALUE)=0A=
+        {=0A=
+          CloseHandle (fh);=0A=
+          dbg_printf (("found!\n"));=0A=
+          return true;=0A=
+        }=0A=
+      break;=0A=
+=0A=
+    case PROCESSNAME:=0A=
+      dbg_printf (("Detect proc name '%s'... ", det->param));=0A=
+      /* Equivalent of RtlInitAnsiString.  */=0A=
+      ansiname.Length =3D ansiname.MaximumLength =3D strlen (det->param);=
=0A=
+      ansiname.Buffer =3D (CHAR *) det->param;=0A=
+      rv =3D RtlAnsiStringToUnicodeString (&unicodename, &ansiname, TRUE);=
=0A=
+      if (rv !=3D STATUS_SUCCESS)=0A=
+        {=0A=
+          printf ("Ansi to unicode conversion failure $%08x\n", (unsigned =
int) rv);=0A=
+          break;=0A=
+        }=0A=
+      found =3D find_process_in_list (pslist, &unicodename);=0A=
+      if (!pRtlFreeUnicodeString)=0A=
+          pRtlFreeUnicodeString =3D (VOID NTAPI (*)(PUNICODE_STRING)) GetP=
rocAddress (LoadLibrary ("ntdll.dll"), "RtlFreeUnicodeString");=0A=
+      if (pRtlFreeUnicodeString)=0A=
+        pRtlFreeUnicodeString (&unicodename);=0A=
+      else=0A=
+        printf ("leaking mem...oops\n");=0A=
+      if (found)=0A=
+        {=0A=
+          dbg_printf (("found!\n"));=0A=
+          return true;=0A=
+        }=0A=
+      break;=0A=
+=0A=
+    case HOOKDLLNAME:=0A=
+      dbg_printf (("Detect hookdll '%s'... ", det->param));=0A=
+      if (find_module_in_list (modlist, det->param))=0A=
+        {=0A=
+          dbg_printf (("found!\n"));=0A=
+          return true;=0A=
+        }=0A=
+      break;=0A=
+=0A=
+    }=0A=
+  dbg_printf (("not found.\n"));=0A=
+  return false;=0A=
+}=0A=
+=0A=
+static struct bad_app_info *=0A=
+find_dodgy_app_info (enum bad_app which_app)=0A=
+{=0A=
+  size_t i;=0A=
+  for (i =3D 0; i < num_of_dodgy_apps; i++)=0A=
+    {=0A=
+      if (big_list_of_dodgy_apps[i].app_id =3D=3D which_app)=0A=
+        return &big_list_of_dodgy_apps[i];=0A=
+    }=0A=
+  return NULL;=0A=
+}=0A=
+=0A=
+/* External entrypoint called from cygcheck.cc/dump_sysinfo.  */=0A=
+void=0A=
+dump_dodgy_apps (int verbose)=0A=
+{=0A=
+  size_t i, n_det =3D 0;=0A=
+  PSYSTEM_PROCESSES pslist;=0A=
+  PSYSTEM_MODULE_INFORMATION modlist;=0A=
+=0A=
+  /* Read system info for detect testing.  */=0A=
+  pslist =3D get_process_list ();=0A=
+  modlist =3D get_module_list ();=0A=
+=0A=
+  /* Go with builtin list for now; later may enhance to=0A=
+  read dodgy apps from a file or download from an URL.  */=0A=
+  for (i =3D 0; i < num_of_dodgy_apps; i++)=0A=
+    {=0A=
+      big_list_of_dodgy_apps[i].found_it =3D false;=0A=
+    }=0A=
+=0A=
+  for (i =3D 0; i < num_of_detects; i++)=0A=
+    {=0A=
+      const struct bad_app_det *det =3D &dodgy_app_detects[i];=0A=
+      struct bad_app_info *found =3D find_dodgy_app_info (det->app);=0A=
+      bool detected =3D detect_dodgy_app (det, pslist, modlist);=0A=
+=0A=
+      /* Not found would mean we coded the lists bad. */=0A=
+      assert (found);=0A=
+      if (detected)=0A=
+        {=0A=
+          ++n_det;=0A=
+          found->found_it |=3D (1 << det->type);=0A=
+        }=0A=
+    }=0A=
+  if (n_det)=0A=
+    {=0A=
+      printf ("\nPotential app conflicts:\n\n");=0A=
+      for (i =3D 0; i < num_of_dodgy_apps; i++)=0A=
+        {=0A=
+          if (big_list_of_dodgy_apps[i].found_it)=0A=
+            {=0A=
+              printf ("%s%s", big_list_of_dodgy_apps[i].details,=20=0A=
+                verbose ? "\nDetected: " : ".\n");=0A=
+              if (!verbose)=0A=
+                continue;=0A=
+              const char *sep =3D "";=0A=
+              if (big_list_of_dodgy_apps[i].found_it & (1 << HKLMKEY))=0A=
+                {=0A=
+                  printf ("HKLM Registry Key");=0A=
+                  sep =3D ", ";=0A=
+                }=0A=
+              if (big_list_of_dodgy_apps[i].found_it & (1 << HKCUKEY))=0A=
+                {=0A=
+                  printf ("%sHKCU Registry Key", sep);=0A=
+                  sep =3D ", ";=0A=
+                }=0A=
+              if (big_list_of_dodgy_apps[i].found_it & (1 << FILENAME))=0A=
+                {=0A=
+                  printf ("%sNamed file", sep);=0A=
+                  sep =3D ", ";=0A=
+                }=0A=
+              if (big_list_of_dodgy_apps[i].found_it & (1 << PROCESSNAME))=
=0A=
+                {=0A=
+                  printf ("%sNamed process", sep);=0A=
+                  sep =3D ", ";=0A=
+                }=0A=
+              if (big_list_of_dodgy_apps[i].found_it & (1 << HOOKDLLNAME))=
=0A=
+                {=0A=
+                  printf ("%sLoaded hook DLL", sep);=0A=
+                }=0A=
+              printf (".\n\n");=0A=
+            }=0A=
+        }=0A=
+    }=0A=
+  /* Tidy up allocations.  */=0A=
+  free (pslist);=0A=
+  free (modlist);=0A=
+}=0A=
+=0A=
Index: winsup/utils/cygcheck.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/utils/cygcheck.cc,v=0A=
retrieving revision 1.95=0A=
diff -p -u -r1.95 cygcheck.cc=0A=
--- winsup/utils/cygcheck.cc	4 Jun 2007 01:57:16 -0000	1.95=0A=
+++ winsup/utils/cygcheck.cc	2 Aug 2007 23:01:04 -0000=0A=
@@ -50,9 +50,13 @@ typedef long long longlong;=0A=
 typedef __int64 longlong;=0A=
 #endif=0A=
=20=0A=
+/* In dump_setup.cc  */=0A=
 void dump_setup (int, char **, bool);=0A=
 void package_find (int, char **);=0A=
 void package_list (int, char **);=0A=
+/* In bloda.cc  */=0A=
+void dump_dodgy_apps (int verbose);=0A=
+=0A=
=20=0A=
 static const char version[] =3D "$Revision: 1.95 $";=0A=
=20=0A=
@@ -1623,6 +1627,8 @@ dump_sysinfo ()=0A=
   if (!cygwin_dll_count)=0A=
     puts ("Warning: cygwin1.dll not found on your path");=0A=
=20=0A=
+  dump_dodgy_apps (verbose);=0A=
+=0A=
   if (is_nt)=0A=
     dump_sysinfo_services ();=0A=
 }=0A=

------=_NextPart_000_0349_01C7D561.CDC80410--
