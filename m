Return-Path: <cygwin-patches-return-4804-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25400 invoked by alias); 2 Jun 2004 20:51:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25383 invoked from network); 2 Jun 2004 20:51:01 -0000
Message-ID: <00ae01c448e3$38784a40$bb583351@jaillet>
From: "Christophe Jaillet" <christophe.jaillet@wanadoo.fr>
To: "Cygwin patches" <cygwin-patches@cygwin.com>
Subject: speed up the function 'find_exec' a bit
Date: Wed, 02 Jun 2004 20:51:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q2/txt/msg00156.txt.bz2

Here is a small patch to speed up the function 'find_exec' a bit
At the top of the function we have :

    bool has_slash = strchr (name, '/');

So there is no need to compute it again a few line latter.


ChangeLog entry
===============
2004-06-02  Christophe Jaillet <christophe.jaillet@wanadoo.fr>

 * spawn.cc: function 'find_exec'. Don't compute >>strchr (name, '/')<<
twice


Patch
=====
diff -p -u -r1.148 spawn.cc
--- spawn.cc 10 Apr 2004 13:45:10 -0000 1.148
+++ spawn.cc 13 Apr 2004 19:39:16 -0000
@@ -114,7 +114,7 @@ find_exec (const char *name, path_conv&

/* Return the error condition if this is an absolute path or if there
is no PATH to search. */
- if (strchr (name, '/') || strchr (name, '\\') ||
+ if (has_slash || strchr (name, '\\') ||
isdrive (name) ||
!(winpath = getwinenv (mywinenv)) ||
!(path = winpath->get_native ()) ||

