Return-Path: <cygwin-patches-return-3681-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29750 invoked by alias); 11 Mar 2003 08:56:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29740 invoked from network); 11 Mar 2003 08:56:57 -0000
Date: Tue, 11 Mar 2003 08:56:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: COTTO Daniel FTRD/DMI/CAE <daniel.cotto@rd.francetelecom.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: A patch for the cygwin1.dll console handler
Message-ID: <20030311085652.GA13544@cygbert.vinschen.de>
Mail-Followup-To: COTTO Daniel FTRD/DMI/CAE <daniel.cotto@rd.francetelecom.com>,
	cygwin-patches@cygwin.com
References: <C691E039D3895C44AB8DFD006B950FB409D18D@lanmhs50.rd.francetelecom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C691E039D3895C44AB8DFD006B950FB409D18D@lanmhs50.rd.francetelecom.fr>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00330.txt.bz2

On Tue, Mar 11, 2003 at 08:02:58AM +0100, COTTO Daniel FTRD/DMI/CAE wrote:
> Hello,
> 
> I have made a patch to the cygwin1.dll .
> Its main purpose is to allow a nul character to be input from a french keyboard. Also this patch adds some othre functions keys. If you are interrested you have the diff -up file from the last cvs 03/03/2003 05:00  fhandler_console.cc
> 
> the binding added are:
> * ctrl-spc: nul character
> * ctrl-f1 through ctrl-f10: \e7~ through \e16~
> * alt-f1 through alt f10: \e[38~ through \e[47~
> * app key binded to: \e[50~
> * ctrl-tab and alt tab bind to esc tab. 
> * and some other minor binding; (see the attachment).
> 
> If you want, you can use this patch and you can add it to a next  version of cygwin1.dll.

That's not how it works unfortunately.  The size of the patch is too big
to go through as insignificant. 

Have another look on http://cygwin.com/contrib.html, please.  You'll
have to sign an assignment form and send it to Red Hat.  As soon as
the assignment form arrived, we can review and eventually incorporate
your patch.  However, you should als add a ChangeLog entry as described
on that page.

A question:  How much sense does it make to change the key bindings
of the cursor block so that Normal/Shift and Ctrl/Alt return the same
code?  Looking into the keycodes returned by an xterm, it returns
for instance on VK_LEFT:

  Normal:  ESC [ D
  Shift:   ESC [ 2 D
  Ctrl:    ESC [ 5 D
  Alt:     ESC ESC [ D

4 different key codes.  Wouldn't it make sense to do the same here?

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
