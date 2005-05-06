Return-Path: <cygwin-patches-return-5429-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13458 invoked by alias); 6 May 2005 14:58:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13436 invoked from network); 6 May 2005 14:58:42 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 6 May 2005 14:58:42 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 00B1513C752; Fri,  6 May 2005 10:58:38 -0400 (EDT)
Date: Fri, 06 May 2005 14:58:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: mkdir -p and network drives
Message-ID: <20050506145838.GD20565@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <002f01c5523f$6d6f38b0$3e0010ac@wirelessworld.airvananet.com> <20050506142213.GA20565@trixie.casa.cgf.cx> <00a701c5524b$a66949b0$3e0010ac@wirelessworld.airvananet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00a701c5524b$a66949b0$3e0010ac@wirelessworld.airvananet.com>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q2/txt/msg00025.txt.bz2

On Fri, May 06, 2005 at 10:55:29AM -0400, Pierre A. Humblet wrote:
>----- Original Message ----- 
>From: "Christopher Faylor" <cgf-no-personal-reply-please@cygwin.com>
>To: <cygwin-patches@cygwin.com>
>Sent: Friday, May 06, 2005 10:22 AM
>Subject: Re: [Patch]: mkdir -p and network drives
>
>>Well, that was kinda my point.  If we can't remove the "//" handling
>>because it breaks bash then adding opendir/readdir stuff seems
>>premature except for the case of ls //foo which is entirely different
>>from ls //.
>
>Sigh.  We need a bash maintainer.  We need to have // working for mkdir
>-p to work, from what I understand of the code snippet that was sent to
>the list.

I thought that Eric Blake implied that // *had* to be translated to /,
as per POSIX.  I wonder how many programs out there translate a
standalone '//' to '/'.

cgf
