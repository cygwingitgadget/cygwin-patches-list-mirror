Return-Path: <cygwin-patches-return-3402-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 875 invoked by alias); 15 Jan 2003 19:31:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 859 invoked from network); 15 Jan 2003 19:31:18 -0000
Message-ID: <3E25B762.B7C0452E@ieee.org>
Date: Wed, 15 Jan 2003 19:31:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: setuid on Win95 and etc_changed, passwd & group.
References: <3.0.5.32.20030115001238.00806440@mail.attbi.com> <20030115060939.GB15975@redhat.com> <3E2570BD.2582F293@ieee.org> <20030115182850.GG15975@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q1/txt/msg00051.txt.bz2

Christopher Faylor wrote:
> 
> Ok.  Got it.  I checked in a patch.
> 
Chris,

In a similar same vein, class fhandler_base has a member open_status
that is set in a dozen places but never read, AFAICT.

I was thinking that those patches would get into 1.3.20
but making etc_changed non heritable might somehow avoid the 
reported BSOD. Let me know if you would like to include it in 1.3.19

Pierre
