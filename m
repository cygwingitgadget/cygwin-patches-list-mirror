Return-Path: <cygwin-patches-return-5929-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19882 invoked by alias); 18 Jul 2006 18:21:47 -0000
Received: (qmail 19855 invoked by uid 22791); 18 Jul 2006 18:21:47 -0000
X-Spam-Check-By: sourceware.org
Received: from Unknown (HELO mailgw03.flightsafety.com) (66.109.93.20)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 18 Jul 2006 18:21:35 +0000
Received: from mailgw03.flightsafety.com (localhost [127.0.0.1]) 	by mailgw03.flightsafety.com (8.13.6/8.13.1) with ESMTP id k6IIJV0K006301 	for <cygwin-patches@cygwin.com>; Tue, 18 Jul 2006 13:19:32 -0500 (CDT)
Received: from dradmast.flightsafety.com ([192.168.93.130]) 	by mailgw03.flightsafety.com (8.13.6/8.13.1) with ESMTP id k6IIJJg2006230 	for <cygwin-patches@cygwin.com>; Tue, 18 Jul 2006 13:19:31 -0500 (CDT)
Received: from srv1163ex1.flightsafety.com ([198.51.28.39]) by dradmast.flightsafety.com with Microsoft SMTPSVC(6.0.3790.211); 	 Tue, 18 Jul 2006 13:21:23 -0500
Received: from pc1163-8460-xp ([198.51.27.93]) by srv1163ex1.flightsafety.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Tue, 18 Jul 2006 08:22:45 -0500
Date: Tue, 18 Jul 2006 18:21:00 -0000
From: Brian Ford <Brian.Ford@flightsafety.com>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: allow read into untouched noreserve mappings
In-Reply-To: <Pine.CYG.4.58.0607171732120.1780@PC1163-8460-XP.flightsafety.com>
Message-ID: <Pine.CYG.4.58.0607180814370.3164@PC1163-8460-XP.flightsafety.com>
References: <Pine.CYG.4.58.0607121318080.2284@PC1163-8460-XP.flightsafety.com>   <20060712202215.GS8759@calimero.vinschen.de>   <Pine.CYG.4.58.0607121536330.3784@PC1163-8460-XP.flightsafety.com>   <20060713103431.GA17383@calimero.vinschen.de>   <Pine.CYG.4.58.0607130933400.1164@PC1163-8460-XP.flightsafety.com>   <Pine.CYG.4.58.0607131315110.3316@PC1163-8460-XP.flightsafety.com>   <20060714091601.GD8759@calimero.vinschen.de>   <Pine.CYG.4.58.0607140931050.3316@PC1163-8460-XP.flightsafety.com>   <20060714155523.GL8759@calimero.vinschen.de>   <Pine.CYG.4.58.0607171205100.2704@PC1163-8460-XP.flightsafety.com>   <20060717204739.GA27029@calimero.vinschen.de>  <Pine.CYG.4.58.0607171732120.1780@PC1163-8460-XP.flightsafety.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00024.txt.bz2

On Mon, 17 Jul 2006, Brian Ford wrote:
> Untested this time because I have to run to an appointment.

Now tested and working fine with no changes.

I guess I can infer from cgf's mail to cygwin-developers that this will
not make it into 1.5.21 :-(.

-- 
Brian Ford
Lead Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
the best safety device in any aircraft is a well-trained crew...
