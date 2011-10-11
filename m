Return-Path: <cygwin-patches-return-7526-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17117 invoked by alias); 11 Oct 2011 19:39:09 -0000
Received: (qmail 17099 invoked by uid 22791); 11 Oct 2011 19:39:07 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-bw0-f43.google.com (HELO mail-bw0-f43.google.com) (209.85.214.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 11 Oct 2011 19:38:47 +0000
Received: by bkas6 with SMTP id s6so11211452bka.2        for <cygwin-patches@cygwin.com>; Tue, 11 Oct 2011 12:38:45 -0700 (PDT)
Received: by 10.204.140.22 with SMTP id g22mr10727488bku.69.1318361925556;        Tue, 11 Oct 2011 12:38:45 -0700 (PDT)
Received: from [192.168.0.50] (a91-153-79-231.elisa-laajakaista.fi. [91.153.79.231])        by mx.google.com with ESMTPS id s12sm22333785bkt.4.2011.10.11.12.38.44        (version=SSLv3 cipher=OTHER);        Tue, 11 Oct 2011 12:38:44 -0700 (PDT)
Message-ID: <4E949B40.20402@gmail.com>
Date: Tue, 11 Oct 2011 19:39:00 -0000
From: =?ISO-8859-1?Q?Teemu_N=E4tkinniemi?= <tnatkinn@gmail.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:6.0.2) Gecko/20110901 Thunderbird/6.0.2
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Add support for Windows 8, first step
Content-Type: multipart/mixed; boundary="------------050508080306070107090105"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q4/txt/msg00016.txt.bz2

This is a multi-part message in MIME format.
--------------050508080306070107090105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Content-length: 302

Hello!

Here's a small patch that enables Cygwin to run on Windows 8 (tested on 
x64 build 8102, the Windows Developer Preview). Windows 8 does not seem 
to support FAST_CWD or the current implementation of FAST_CWD is not 
compatible with Windows 8 so it is disabled at the moment.

Teemu Nätkinniemi

--------------050508080306070107090105
Content-Type: text/plain; charset=windows-1252;
 name="wincap_win8.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="wincap_win8.patch"
Content-length: 1590

2011-10-11  Teemu Nätkinniemi  <tnatkinn@gmail.com>

	* wincap.cc (wincap_8): Add support to Windows 8
	(wincapc::init): Ditto

--- wincap.cc.orig	2011-07-30 23:51:03.000000000 +0300
+++ wincap.cc	2011-10-11 22:13:44.556795800 +0300
@@ -263,6 +263,36 @@
   has_stack_size_param_is_a_reservation:true,
 };
 
+wincaps wincap_8 __attribute__((section (".cygwin_dll_common"), shared)) = {
+  max_sys_priv:SE_CREATE_SYMBOLIC_LINK_PRIVILEGE,
+  is_server:false,
+  has_physical_mem_access:false,
+  has_create_global_privilege:true,
+  has_ioctl_storage_get_media_types_ex:true,
+  has_disk_ex_ioctls:true,
+  has_buggy_restart_scan:false,
+  has_mandatory_integrity_control:true,
+  needs_logon_sid_in_sid_list:false,
+  needs_count_in_si_lpres2:false,
+  has_recycle_dot_bin:true,
+  has_gaa_prefixes:true,
+  has_gaa_on_link_prefix:true,
+  supports_all_posix_ai_flags:true,
+  has_restricted_stack_args:false,
+  has_transactions:true,
+  has_recvmsg:true,
+  has_sendmsg:true,
+  has_broken_udf:false,
+  has_console_handle_problem:true,
+  has_broken_alloc_console:true,
+  has_always_all_codepages:true,
+  has_localenames:true,
+  has_fast_cwd:false,
+  has_restricted_raw_disk_access:true,
+  use_dont_resolve_hack:false,
+  has_stack_size_param_is_a_reservation:true,
+};
+
 wincapc wincap __attribute__((section (".cygwin_dll_common"), shared));
 
 void
@@ -320,9 +350,12 @@
 		  case 0:
 		    caps = &wincap_vista;
 		    break;
-		  default:
+		  case 1:
 		    caps = &wincap_7;
 		    break;
+		  default:
+		    caps = &wincap_8;
+		    break;
 		}
 	      break;
 	    default:

--------------050508080306070107090105--
