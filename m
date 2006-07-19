Return-Path: <cygwin-patches-return-5932-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19167 invoked by alias); 19 Jul 2006 02:51:07 -0000
Received: (qmail 19130 invoked by uid 22791); 19 Jul 2006 02:51:05 -0000
X-Spam-Check-By: sourceware.org
Received: from fios.cgf.cx (HELO cgf.cx) (71.248.179.44)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 19 Jul 2006 02:51:04 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 225D013C2DE; Tue, 18 Jul 2006 22:51:03 -0400 (EDT)
Date: Wed, 19 Jul 2006 02:51:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: allow read into untouched noreserve mappings
Message-ID: <20060719025102.GA2980@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20060713103431.GA17383@calimero.vinschen.de> <Pine.CYG.4.58.0607130933400.1164@PC1163-8460-XP.flightsafety.com> <Pine.CYG.4.58.0607131315110.3316@PC1163-8460-XP.flightsafety.com> <20060714091601.GD8759@calimero.vinschen.de> <Pine.CYG.4.58.0607140931050.3316@PC1163-8460-XP.flightsafety.com> <20060714155523.GL8759@calimero.vinschen.de> <Pine.CYG.4.58.0607171205100.2704@PC1163-8460-XP.flightsafety.com> <20060717204739.GA27029@calimero.vinschen.de> <Pine.CYG.4.58.0607171732120.1780@PC1163-8460-XP.flightsafety.com> <Pine.CYG.4.58.0607180814370.3164@PC1163-8460-XP.flightsafety.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0607180814370.3164@PC1163-8460-XP.flightsafety.com>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00027.txt.bz2

On Tue, Jul 18, 2006 at 08:22:38AM -0500, Brian Ford wrote:
>On Mon, 17 Jul 2006, Brian Ford wrote:
>> Untested this time because I have to run to an appointment.
>
>Now tested and working fine with no changes.
>
>I guess I can infer from cgf's mail to cygwin-developers that this will
>not make it into 1.5.21 :-(.

I guess the fact that Corinna mentioned installing this into a branch
wasn't a big enough hint?

cgf
