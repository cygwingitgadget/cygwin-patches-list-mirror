Return-Path: <cygwin-patches-return-2424-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 3840 invoked by alias); 14 Jun 2002 01:11:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3825 invoked from network); 14 Jun 2002 01:11:48 -0000
Message-Id: <3.0.5.32.20020613205857.0080d800@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Thu, 13 Jun 2002 18:11:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: Reorganizing internal_getlogin() -- modified Pierre patch
In-Reply-To: <20020613052709.GA17779@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q2/txt/msg00407.txt.bz2

At 01:27 AM 6/13/2002 -0400, Christopher Faylor wrote:
>Ok, here's a patch with the rest of the environment fleshed out (I hope).
>
>I don't know enough about this stuff to know if this works or not but it
>doesn't core dump in very simple test cases.
>
>Does it make sense?  That's the question.

Chris,

At a high level everything makes a lot of sense.
Can the patch you sent 24h ago be applied against the current 
cvs or do you have something more recent?

I also tried to build the current cvs but get an error
In file included from ../../../../src/winsup/cygwin/assert.cc:13:
/src/winsup/w32api/include/wingdi.h:2521: `HENMETAFILE' was not declared in
this scope

Pierre
