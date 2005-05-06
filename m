Return-Path: <cygwin-patches-return-5431-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1880 invoked by alias); 6 May 2005 15:13:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1729 invoked from network); 6 May 2005 15:13:26 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 6 May 2005 15:13:26 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id DDEAD13C752; Fri,  6 May 2005 11:13:25 -0400 (EDT)
Date: Fri, 06 May 2005 15:13:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: mkdir -p and network drives
Message-ID: <20050506151325.GE20565@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <002f01c5523f$6d6f38b0$3e0010ac@wirelessworld.airvananet.com> <20050506142213.GA20565@trixie.casa.cgf.cx> <00a701c5524b$a66949b0$3e0010ac@wirelessworld.airvananet.com> <20050506145838.GD20565@trixie.casa.cgf.cx> <00b101c5524d$4b889990$3e0010ac@wirelessworld.airvananet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00b101c5524d$4b889990$3e0010ac@wirelessworld.airvananet.com>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q2/txt/msg00027.txt.bz2

On Fri, May 06, 2005 at 11:07:13AM -0400, Pierre A. Humblet wrote:
>That's not Paul Eggert's position,
>http://cygwin.com/ml/cygwin/2005-05/msg00251.html I don't expect
>problems with //, we had it working in cvs for a while and only bash
>had issues.  Program translating // to / should already have problems
>and they won't be affected if Cygwin keeps //

Hmm.  I missed that message.  Seems rather... uncooperative... to check in
a "fix" for Cygwin that wouldn't actually work on Cygwin.  I certainly
am enjoying the "Cygwin is broken so let's fix it!" implication, though.

cgf
