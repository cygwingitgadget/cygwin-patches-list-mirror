Return-Path: <cygwin-patches-return-2734-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 19540 invoked by alias); 26 Jul 2002 20:33:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19526 invoked from network); 26 Jul 2002 20:33:40 -0000
Message-ID: <3D41B156.428B8DDC@ieee.org>
Date: Fri, 26 Jul 2002 13:33:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: setgroups
References: <3.0.5.32.20020726000410.00813de0@mail.attbi.com> <20020726105948.A30785@cygbert.vinschen.de> <3D415128.373F4E59@ieee.org> <20020726214913.M3921@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00182.txt.bz2

Corinna Vinschen wrote:

> No, that's perfectly ok.  Hmm, somehow I'd still wish to avoid two
> implementations of sidlists...

Of course that would be nice! The problem I had with cygsidlist is the 
use of "new". We could add a flag to use "new" or cmalloc, depending on 
the use, but it gets ugly (I assumed it wouldn't be acceptable to use
cmalloc all the time). 
Also by having a new class I can handle the primary group in a 
special way, but this could be added to cygsidlist.

Pierre
