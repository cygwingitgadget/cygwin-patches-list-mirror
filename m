Return-Path: <cygwin-patches-return-4195-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19855 invoked by alias); 10 Sep 2003 13:36:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19825 invoked from network); 10 Sep 2003 13:36:24 -0000
Message-ID: <3F5F28C5.F99C5B92@phumblet.no-ip.org>
Date: Wed, 10 Sep 2003 13:36:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: Pierre.Humblet@ieee.org
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: Part 2 of Fixing a security hole in mount table.
References: <3.0.5.32.20030909235426.008236c0@incoming.verizon.net> <20030910075433.GB5268@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q3/txt/msg00211.txt.bz2

Corinna Vinschen wrote:
> 
> Looks good to me, except for:
> 
> > -  char name[UNLEN + 1] = "";
> > +  char name[UNLEN > 127 ? UNLEN + 1 : 128] = "";
> 
> Huh?  Why that?  UNLEN is defined as 256 in lmcons.h so I don't understand
> the reasoning behind that complexity.
> 
Just being paranoid. "name" can either contain a user name
(length UNLEN + 1) or a sid (length 128). 
This construction costs nothing (the compiler does the work),
saves me from having to look up the .h file, and protects us
against possible header file changes.

Pierre
