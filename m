Return-Path: <cygwin-patches-return-2403-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28838 invoked by alias); 13 Jun 2002 02:45:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28813 invoked from network); 13 Jun 2002 02:45:35 -0000
Date: Wed, 12 Jun 2002 19:45:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Reorganizing internal_getlogin()
Message-ID: <20020613024602.GA14247@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20020612205711.007f7300@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20020612205711.007f7300@mail.attbi.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00386.txt.bz2

On Wed, Jun 12, 2002 at 08:57:11PM -0400, Pierre A. Humblet wrote:
>	* uinfo.cc (uinfo_init): Add an argument. Only call internal_getlogin
>	when starting from a non Cygwin process and use the values returned
>	in user.
>	(internal_getlogin): Simplify to case where starting from a non
>	Cygwin process. Store return values in user and return void. Do not set
>	the Windows default environment.

Btw, I don't think you included this patch.  I was going to take a stab at
consolidating it with my recent changes.

In general, it's a lot easier if you just include one giant patch file
rather than a bunch of individual patches.  This is what is suggested
in http://cygwin.com/contrib.html .

cgf
