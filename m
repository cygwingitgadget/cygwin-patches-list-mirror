Return-Path: <cygwin-patches-return-3887-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30837 invoked by alias); 24 May 2003 18:02:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30810 invoked from network); 24 May 2003 18:02:07 -0000
Date: Sat, 24 May 2003 18:02:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Console title
Message-ID: <20030524180206.GD5604@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <BAY1-DAV43h4VGXTnKP000049e0@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY1-DAV43h4VGXTnKP000049e0@hotmail.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00114.txt.bz2

On Sat, May 24, 2003 at 03:43:46PM +0200, Micha Nelissen wrote:
>Hi,
>
>This makes the set title go after the current title, instead of replacing
>it. You need to enable hardstatus support in termcap to be able to notice
>the difference. In particular the entries 'hs', 'fs', 'ts' and 'ds' are
>needed. See 'man screen'.

You have offered no justification for this change.  Obviously we could have
appended the title after the existing title if we wanted to.

What's the rationale here?

cgf
