Return-Path: <cygwin-patches-return-6240-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3961 invoked by alias); 16 Jan 2008 14:50:28 -0000
Received: (qmail 3949 invoked by uid 22791); 16 Jan 2008 14:50:27 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-96-237-107-182.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (96.237.107.182)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 16 Jan 2008 14:50:05 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 747B76BB41E; Wed, 16 Jan 2008 09:50:03 -0500 (EST)
Date: Wed, 16 Jan 2008 14:50:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] un-NT-ify cygcheck (was: cygwin 1.5.25-7: cygcheck 	does   not   work?)
Message-ID: <20080116145003.GA5911@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <047a01c84375$2f2cf810$2e08a8c0@CAM.ARTIMI.COM> <20071221030715.GB28930@ednor.casa.cgf.cx> <476B3472.17126868@dessent.net> <20071222094851.GA27315@calimero.vinschen.de> <20071222160838.GA6034@ednor.casa.cgf.cx> <20071223092832.GM29568@calimero.vinschen.de> <20080107131102.GO29568@calimero.vinschen.de> <20080107131231.GA23967@ednor.casa.cgf.cx> <20080111155845.GA27287@ednor.casa.cgf.cx> <20080116111939.GK5097@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080116111939.GK5097@calimero.vinschen.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00014.txt.bz2

On Wed, Jan 16, 2008 at 12:19:39PM +0100, Corinna Vinschen wrote:
>On Jan 11 10:58, Christopher Faylor wrote:
>> On Mon, Jan 07, 2008 at 08:12:32AM -0500, Christopher Faylor wrote:
>> >On Mon, Jan 07, 2008 at 02:11:02PM +0100, Corinna Vinschen wrote:
>> >>On Dec 23 10:28, Corinna Vinschen wrote:
>> >>> On Dec 22 11:08, Christopher Faylor wrote:
>> >>> > I have some pipe-related patches that probably should go into the branch
>> >>> > too, FYI.  I'm just waiting for word that they fix a reported problem.
>> >>> 
>> >>> Ok, I'll wait.  No worries.
>> >>
>> >>Did you get feedback about your change?
>> >
>> >No.  I had some email problems in the last month so I'm resyncing with the
>> >people who would be testing.
>> 
>> I'm waiting for feedback now...
>
>Any news?

No.

>Out of curiosity, would you mind to send a sneak preview of the patch
>and what problem it's meant to solve?

The sneak preview is already in 1.7.x.  There is a problem with the code in
1.7.x (as you know) which shouldn't be an issue for 1.5.x.

cgf
