Return-Path: <cygwin-patches-return-4757-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2683 invoked by alias); 14 May 2004 18:37:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2654 invoked from network); 14 May 2004 18:37:44 -0000
Date: Fri, 14 May 2004 18:37:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fix gethwnd race
Message-ID: <20040514183744.GA11218@coe.bosbc.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.58.0405131444340.3944@fordpc.vss.fsi.com> <20040513200801.GA8666@coe.bosbc.com> <Pine.CYG.4.58.0405131519060.3944@fordpc.vss.fsi.com> <20040513210306.GD11731@coe.bosbc.com> <Pine.CYG.4.58.0405131614030.3944@fordpc.vss.fsi.com> <20040514042403.GA20769@coe.bosbc.com> <Pine.CYG.4.58.0405141004020.3944@fordpc.vss.fsi.com> <20040514162017.GA21214@coe.bosbc.com> <Pine.CYG.4.58.0405141205590.3944@fordpc.vss.fsi.com> <20040514180553.GB10458@coe.bosbc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040514180553.GB10458@coe.bosbc.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q2/txt/msg00109.txt.bz2

On Fri, May 14, 2004 at 02:05:53PM -0400, Christopher Faylor wrote:
>I couldn't see anything in MSDN which supported it.

Found it.  It was in the GetMessage description.  Oh well.

cgf
