Return-Path: <cygwin-patches-return-2502-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 19666 invoked by alias); 24 Jun 2002 10:05:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19649 invoked from network); 24 Jun 2002 10:05:08 -0000
Date: Mon, 24 Jun 2002 06:01:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Windows username in get_group_sidlist
Message-ID: <20020624120506.Z22705@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20020623235117.008008f0@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20020623235117.008008f0@mail.attbi.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00485.txt.bz2

On Sun, Jun 23, 2002 at 11:51:17PM -0400, Pierre A. Humblet wrote:
> Corinna,
> 
> get_group_sidlist currently uses the Windows username when
> getting the supplementary group list. Here is a fix.
> 
> It may be paranoid in checking pw->pw_name is not NULL
> (it's not always done in Cygwin, because it can't 
> happen currently), delete that if you wish.

Your patch looks good but I can't apply it.  patch(1) doesn't like
it, probably due to ricocheting whitespaces.  Could you resend it,
please?

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
