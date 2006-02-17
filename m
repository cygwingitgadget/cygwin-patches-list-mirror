Return-Path: <cygwin-patches-return-5771-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22295 invoked by alias); 17 Feb 2006 21:42:00 -0000
Received: (qmail 22285 invoked by uid 22791); 17 Feb 2006 21:42:00 -0000
X-Spam-Check-By: sourceware.org
Received: from cgf.cx (HELO cgf.cx) (24.61.23.223)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 17 Feb 2006 21:41:55 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 0C52113C122; Fri, 17 Feb 2006 16:41:54 -0500 (EST)
Date: Fri, 17 Feb 2006 21:42:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: raw email addresses and ChangeLog entries?
Message-ID: <20060217214153.GA28352@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20060216104607.fb30e530d17747c2b054d625b8945d88.ac8efb9ae7.wbe@email.secureserver.net> <20060217111845.GS26541@calimero.vinschen.de> <Pine.CYG.4.58.0602170948040.1684@PC1163-8460-XP.flightsafety.com> <20060217195339.GB5791@calimero.vinschen.de> <Pine.CYG.4.58.0602171521380.1684@PC1163-8460-XP.flightsafety.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0602171521380.1684@PC1163-8460-XP.flightsafety.com>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00080.txt.bz2

On Fri, Feb 17, 2006 at 03:24:41PM -0600, Brian Ford wrote:
>On Fri, 17 Feb 2006, Corinna Vinschen wrote:
>>On Feb 17 09:52, Brian Ford wrote:
>>>On Fri, 17 Feb 2006, Corinna Vinschen wrote:
>>>>On Feb 16 10:46, Jerry D. Hedden wrote:
>>>>
>>>>Would you please don't copy raw email addresses in your replies?
>>>>http://cygwin.com/acronyms/#PCYMTNQREAIYR
>>>>
>>>>>2006-02-16  Jerry D. Hedden  <jerry at hedden dot us>
>>>
>>>I've always been confused about the above dichotomy.  Is it ok to
>>>obfuscate ChangeLog email addresses?  Otherwise, what's the point of
>>>PCYMTNQREAIYR requests in cygwin-patches?
>
>>Dunno if I'm speaking for Chris here, too, but I usually send patches
>>to other lists without the date/name/email header, for the simple
>>reason that the date will change anyway to the date of checkin.  The
>>name and email address is given in the mail header anyway, so why
>>bother?
>
>Sounds good.  I'm all for it if cgf agrees.

Sorry, but I don't.  I've even mentioned what I prefer recently, i.e.,
in theory a ChangeLog is supposed to be a cut/paste with no
interpretation.  If I get a patch today, I should be able to just cut
and paste it today without any editing.

AFAIK, ChangeLogs have *always* been an exception to the "don't post raw
email addresses" rule.  Look at the gdb or gcc patches mailing lists.

The "don't use raw email addresses" rule that we try to enforce in the
Cygwin lists is basically a "don't do it because it is stupid and it
causes harm" rule.  There is typically no reason to put a raw email
address in the body of a non-patch message.  There *is* a reason to use
an email address when the email address is supposed to eventually be
recorded in a ChangeLog.

However, this isn't really worth a lot of debate (not that that has ever
stopped anyone in these lists).  It isn't the end of the world if
someone doesn't send their email address but my preference is to get a
complete ChangeLog and that seems to be what most other lists prefer as
well.

cgf
