Return-Path: <cygwin-patches-return-3610-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18688 invoked by alias); 21 Feb 2003 02:20:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18679 invoked from network); 21 Feb 2003 02:20:11 -0000
Date: Fri, 21 Feb 2003 02:20:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: access()
Message-ID: <20030221022024.GA26069@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030220201534.007fb310@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030220201534.007fb310@mail.attbi.com>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00259.txt.bz2

On Thu, Feb 20, 2003 at 08:15:34PM -0500, Pierre A. Humblet wrote:
>2) I am not sure when to use LoadDLLfuncEx vs. LoadDLLfunc.

LoadDLLfunc issues an error if a function isn't found.  LoadDllFuncEx
lets you return an error code when the function isn't found.

cgf
