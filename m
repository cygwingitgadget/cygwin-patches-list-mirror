Return-Path: <cygwin-patches-return-3840-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14676 invoked by alias); 30 Apr 2003 08:23:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14410 invoked from network); 30 Apr 2003 08:21:07 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Wed, 30 Apr 2003 08:23:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH] revert finline changes to Makefile.in
Message-ID: <Pine.WNT.4.44.0304301010290.357-200000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="616361-31248-1051690839=:357"
X-SW-Source: 2003-q2/txt/msg00067.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--616361-31248-1051690839=:357
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 400


I would like to revert my patch to Makefile.in to enable finline-functions
optimization. This change to Makefile.in is not obvious to use. A better
way to enable finline-functions is to set CXXFLAGS properly, for example:

export CFLAGS="-O2 -s -pipe"
export CXXFLAGS="$CFLAGS -finline-functions"
configure

2003-04-30  Thomas Pfaff  <tpfaff@gmx.net>

	* Makefile.in: Revert patch from 2003-04-17.


--616361-31248-1051690839=:357
Content-Type: TEXT/plain; name="finline-revert.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.WNT.4.44.0304301020390.357@algeria.intern.net>
Content-Description: 
Content-Disposition: attachment; filename="finline-revert.patch"
Content-length: 415

LS0tIE1ha2VmaWxlLmlufgkyMDAzLTA0LTMwIDA5OjM5OjE5LjAwMDAwMDAw
MCArMDIwMAorKysgTWFrZWZpbGUuaW4JMjAwMy0wNC0zMCAxMDowNDo0My4w
MDAwMDAwMDAgKzAyMDAKQEAgLTgwLDkgKzgwLDYgQEAgQ0ZMQUdTPUBDRkxB
R1NACiBvdmVycmlkZSBDRkxBR1MrPS1NTUQgJHskKCpGKV9DRkxBR1N9CiBD
WFg9QENYWEAKIENYWEZMQUdTPUBDWFhGTEFHU0AKLWlmZXEgKCQoQ1lHSU5M
SU5FKSwxKQotb3ZlcnJpZGUgQ1hYRkxBR1MrPS1maW5saW5lLWZ1bmN0aW9u
cwotZW5kaWYKIAogQVI6PUBBUkAKIEFSX0ZMQUdTOj1xdgo=

--616361-31248-1051690839=:357--
