Return-Path: <cygwin-patches-return-1669-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 13525 invoked by alias); 11 Jan 2002 12:52:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13506 invoked from network); 11 Jan 2002 12:52:22 -0000
Message-ID: <3C3EDFD8.A48A3978@yahoo.com>
Date: Fri, 11 Jan 2002 04:52:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: CP List <Cygwin-Patches@Cygwin.Com>
Subject: [Fwd: src/winsup/w32api ChangeLog include/ntsecapi.h ...]
Content-Type: multipart/mixed;
 boundary="------------4F7C7FDCC953D7DE08C85CD2"
X-SW-Source: 2002-q1/txt/msg00026.txt.bz2

This is a multi-part message in MIME format.
--------------4F7C7FDCC953D7DE08C85CD2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 56

I've asked Danny Smith to review these patches.

Earnie.
--------------4F7C7FDCC953D7DE08C85CD2
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Content-length: 3022

X-Apparently-To: earnie_boyd@yahoo.com via web12105.mail.yahoo.com; 11 Jan 2002 02:23:28 -0800 (PST)
X-RocketRCL: 1947;1;649379848
X-Track: 2: 40
Received: from sources.redhat.com (209.249.29.67)
  by mta432.mail.yahoo.com with SMTP; 11 Jan 2002 02:23:28 -0800 (PST)
Received: (qmail 17074 invoked by alias); 11 Jan 2002 10:23:23 -0000
Mailing-List: contact cygwin-cvs-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Unsubscribe: <mailto:cygwin-cvs-unsubscribe-earnie_boyd=yahoo.com@cygwin.com>
List-Subscribe: <mailto:cygwin-cvs-subscribe@cygwin.com>
List-Post: <mailto:cygwin-cvs@cygwin.com>
List-Help: <mailto:cygwin-cvs-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-cvs-owner@cygwin.com
Delivered-To: mailing list cygwin-cvs@cygwin.com
Received: (qmail 17062 invoked by uid 9126); 11 Jan 2002 10:23:21 -0000
Date: 11 Jan 2002 10:23:21 -0000
Message-ID: <20020111102321.17060.qmail@sources.redhat.com>
From: rbcollins@cygwin.com
To: cygwin-cvs@cygwin.com
Subject: src/winsup/w32api ChangeLog include/ntsecapi.h ...
X-Mozilla-Status2: 00000000
Content-length: 1947

CVSROOT:	/cvs/src
Module name:	src
Changes by:	rbcollins@sources.redhat.com	2002-01-11 02:23:21

Modified files:
	winsup/w32api  : ChangeLog 
	winsup/w32api/include: ntsecapi.h objbase.h rapi.h rpc.h 
	                       rpcdce.h rpcdcep.h rpcndr.h rpcnsip.h 
	                       rpcproxy.h windef.h 

Log message:
	2002-01-11 Ralf Habacker  <Ralf.Habacker@freenet.de>
	
	* include/ntsecapi.h:  Fixed missing void parameter type in some prototypes.
	* include/objbase.h: Ditto.
	* include/rapi.h: Ditto.
	* include/rpc.h: Ditto.
	* include/rpcdce.h: Ditto.
	* include/rpcdcep.h: Ditto.
	* include/rpcndr.h: Ditto.
	* include/rpcnsip.h: Ditto.
	* include/rpcproxy.h: Ditto.
	* include/windef.h: Ditto.

Patches:
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/ChangeLog.diff?cvsroot=src&r1=1.137&r2=1.138
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/ntsecapi.h.diff?cvsroot=src&r1=1.6&r2=1.7
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/objbase.h.diff?cvsroot=src&r1=1.3&r2=1.4
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/rapi.h.diff?cvsroot=src&r1=1.2&r2=1.3
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/rpc.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/rpcdce.h.diff?cvsroot=src&r1=1.3&r2=1.4
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/rpcdcep.h.diff?cvsroot=src&r1=1.3&r2=1.4
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/rpcndr.h.diff?cvsroot=src&r1=1.3&r2=1.4
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/rpcnsip.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/rpcproxy.h.diff?cvsroot=src&r1=1.2&r2=1.3
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/windef.h.diff?cvsroot=src&r1=1.6&r2=1.7

--------------4F7C7FDCC953D7DE08C85CD2--


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

