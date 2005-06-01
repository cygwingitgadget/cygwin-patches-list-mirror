Return-Path: <cygwin-patches-return-5503-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15113 invoked by alias); 1 Jun 2005 21:29:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14757 invoked by uid 22791); 1 Jun 2005 21:29:43 -0000
Received: from smtp2.wanadoo.fr (HELO smtp2.wanadoo.fr) (193.252.22.29)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Wed, 01 Jun 2005 21:29:43 +0000
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0206.wanadoo.fr (SMTP Server) with ESMTP id 373951C001CF
	for <cygwin-patches@cygwin.com>; Wed,  1 Jun 2005 23:29:42 +0200 (CEST)
Received: from none (AOrleans-204-1-38-178.w193-252.abo.wanadoo.fr [193.252.205.178])
	by mwinf0206.wanadoo.fr (SMTP Server) with SMTP id C86EC1C001AE
	for <cygwin-patches@cygwin.com>; Wed,  1 Jun 2005 23:29:41 +0200 (CEST)
X-ME-UUID: 20050601212941821.C86EC1C001AE@mwinf0206.wanadoo.fr
Message-ID: <003601c566f0$b7de23a0$96cefea9@none>
From: "Christophe Jaillet" <christophe.jaillet@wanadoo.fr>
To: "Cygwin patches" <cygwin-patches@cygwin.com>
Subject: memset & 'VirtualQuery'
Date: Wed, 01 Jun 2005 21:29:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-SW-Source: 2005-q2/txt/msg00099.txt.bz2

   Hi,

when looking thrue cygwin code looking for function 'VirtualQuery', we can
see that it is passed a structure (MEMORY_BASIC_INFORMATION).
In some cases, this structure is memset'ed to 0 before the call, sometimes,
not.

My very own opinion about it, is that there is no need to reset the content
of the structure before the call and in some places a call to memset can be
avoided.

Here is a list of the call to 'VirtualQuery' which uses memset and could be
optimised :
   - cygthread.cc (terminate_thread)
   - fork.cc (stack_base)
   - exceptions.cc (interruptible)

All the other calls to 'VirtualQuery' don't use memset.

If you think it is useful, I can provide a patch for this in the next few
days.

CJ


