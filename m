Return-Path: <cygwin-patches-return-4213-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18391 invoked by alias); 14 Sep 2003 02:09:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18094 invoked from network); 14 Sep 2003 02:09:15 -0000
Message-Id: <3.0.5.32.20030913220742.0082d260@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sun, 14 Sep 2003 02:09:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Part 2 of Fixing a security hole in pinfo.
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q3/txt/msg00229.txt.bz2

This is the second and final part of the pinfo security patch. 

It creates the _pinfo mapping with appropriate security attributes. 
They temporarily still give write access to Everyone, until Chris releases
his new method for children to signal their parents.

However things are not that simple. The acl that needs to be built
is more complex than what sec_acl was designed for. Thus I had to
add arguments, making changes in security.h and sec_helper.cc in the process.
Because of the new arguments, two calls had to be slightly modified
in create_token and seteuid32.
Finally because the well_known_xxx_sid's are used earlier than before,
the initialization order in dcrt0.cc had to be adjusted.

There is one change that is not directly related: I removed the dependency
on allow_ntsec in sec_user{,_nih}. The main reason is that using 
sec_none{,nih} does not give any access to Admins in the nontsec case, 
which doesn't seem desirable. The old code is probably a leftover of the 
early days of ntsec.

Pierre

2003-09-13  Pierre Humblet <pierre.humblet@ieee.org>

	* security.h (__sec_user): Add "access2" argument.
	(sec_acl): Add "original" and "access2" arguments.
	(sec_user): Add "sid2" and "access2" argument. Remove dependence on 
	allow_ntsec.
	(sec_user_nih): Ditto.
	* sec_helper.cc (__sec_user): Add "has_security" test.
	Call sec_acl with new arguments, letting it handle original_sid.
	(sec_acl): Add "original" and "access2" arguments. Handle original_sid 
	depending on flag but avoiding duplicates. Use "access2" for sid2.
	* pinfo.cc (pinfo::init): Use security attributes created by sec_user
	when creating the mapping.
	* security.cc (create_token): Adjust arguments in call to sec_acl.
	Call sec_user instead of __sec_user.
	* syscall.cc (seteuid32):  Adjust arguments in call to sec_acl. Remove 
	now unnecessary test. Remove useless conversions to psid.
	* dcrt0.cc (dll_crt0_1): Call cygsid::init before pinfo_init.    
