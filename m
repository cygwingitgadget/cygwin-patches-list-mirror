Return-Path: <cygwin-patches-return-3566-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16932 invoked by alias); 13 Feb 2003 23:45:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16799 invoked from network); 13 Feb 2003 23:45:36 -0000
Date: Thu, 13 Feb 2003 23:45:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Produce beeps using soundcard
Message-ID: <20030213234650.GA32482@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030213232335.GB31877@redhat.com> <000b01c2d3b9$41b49780$2101a8c0@BRAEMARINC.COM> <20030213234525.GA32409@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030213234525.GA32409@redhat.com>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00215.txt.bz2

On Thu, Feb 13, 2003 at 06:45:25PM -0500, Christopher Faylor wrote:
>On Thu, Feb 13, 2003 at 05:40:13PM -0600, Gary R Van Sickle wrote:
>>What am I missing here?  Beep (412, 100) ==> MessageBeep ((unsigned)-1) and
>>we're done, right?  No need for any CYGWIN= hoobajoob or another static BOOL
>>or anything.
>
>Will that work right on PCs without a soundcard?  If so, when then, duh.
                                                          well
>
>cgf
(1 beer too many)
