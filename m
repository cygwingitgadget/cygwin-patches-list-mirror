Return-Path: <cygwin-patches-return-2503-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 8272 invoked by alias); 24 Jun 2002 13:01:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8245 invoked from network); 24 Jun 2002 13:01:39 -0000
Date: Mon, 24 Jun 2002 06:15:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Windows username in get_group_sidlist
Message-ID: <20020624130226.GA19789@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20020623235117.008008f0@mail.attbi.com> <20020624120506.Z22705@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020624120506.Z22705@cygbert.vinschen.de>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00486.txt.bz2

On Mon, Jun 24, 2002 at 12:05:06PM +0200, Corinna Vinschen wrote:
>On Sun, Jun 23, 2002 at 11:51:17PM -0400, Pierre A. Humblet wrote:
>>It may be paranoid in checking pw->pw_name is not NULL (it's not always
>>done in Cygwin, because it can't happen currently), delete that if you
>>wish.
>
>Your patch looks good but I can't apply it.  patch(1) doesn't like it,
>probably due to ricocheting whitespaces.  Could you resend it, please?

patch -l seemed to get most of the way there.  Fixing a line wrap problem
got the rest of the way.  I applied the patch, since Corinna approved it.

Thanks.

cgf
