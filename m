Return-Path: <cygwin-patches-return-4806-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21259 invoked by alias); 2 Jun 2004 21:21:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21250 invoked from network); 2 Jun 2004 21:21:40 -0000
Date: Wed, 02 Jun 2004 21:21:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: speed up the function 'find_exec' a bit
Message-ID: <20040602212139.GA7574@coe.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <00ae01c448e3$38784a40$bb583351@jaillet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00ae01c448e3$38784a40$bb583351@jaillet>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q2/txt/msg00158.txt.bz2

On Wed, Jun 02, 2004 at 10:50:19PM +0200, Christophe Jaillet wrote:
>Here is a small patch to speed up the function 'find_exec' a bit
>At the top of the function we have :
>
>    bool has_slash = strchr (name, '/');
>
>So there is no need to compute it again a few line latter.
>
>
>ChangeLog entry
>===============
>2004-06-02  Christophe Jaillet <christophe.jaillet@wanadoo.fr>
>
> * spawn.cc: function 'find_exec'. Don't compute >>strchr (name, '/')<<
>twice

Applied with some stylistic changes and a new ChangeLog entry.

Thanks.
cgf
