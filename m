Return-Path: <cygwin-patches-return-6867-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1195 invoked by alias); 15 Dec 2009 13:00:52 -0000
Received: (qmail 1182 invoked by uid 22791); 15 Dec 2009 13:00:50 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 15 Dec 2009 13:00:46 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 6E6476D417D; Tue, 15 Dec 2009 14:00:36 +0100 (CET)
Date: Tue, 15 Dec 2009 13:00:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: console enhancements: mouse events etc
Message-ID: <20091215130036.GA19394@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4AF73FEC.2050300@towo.net>  <20091119152632.GJ29173@calimero.vinschen.de>  <20091119160054.GB8185@ednor.casa.cgf.cx>  <20091119160948.GA1883@calimero.vinschen.de>  <4B1C04D1.8010707@towo.net>  <20091214114715.GG8059@calimero.vinschen.de>  <4B266528.7090006@towo.net>  <20091214162953.GO8059@calimero.vinschen.de>  <4B266F9B.6070204@towo.net>  <20091214171323.GS8059@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091214171323.GS8059@calimero.vinschen.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00198.txt.bz2

On Dec 14 18:13, Corinna Vinschen wrote:
> On Dec 14 18:02, Thomas Wolff wrote:
> > Do you maintain two checkouts, an unpatched one to base on?
> 
> Of course not.  What's a source code control system good for if you do
> everything manually?  You should really start RTF cvs M.  `info cvs' for
> a start.

I've applied the first part of the patch:

	* fhandler_console.cc (char_command): Fix code to select dim mode
	to 2 rather than 9.  Add entries for mode 22 (normal, not bold)
	28 (visible, not invisible), 25 (not blinking).

Btw., please don't add the ChangeLog entries to the patch, just add
them as plain text to your mail.  Patches to ChangeLogs almost always
don't apply cleanly.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
