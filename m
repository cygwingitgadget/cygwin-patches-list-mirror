Return-Path: <cygwin-patches-return-3406-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32084 invoked by alias); 15 Jan 2003 20:28:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32071 invoked from network); 15 Jan 2003 20:28:13 -0000
Date: Wed, 15 Jan 2003 20:28:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: setuid on Win95 and etc_changed, passwd & group.
Message-ID: <20030115202912.GJ23351@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030115001238.00806440@mail.attbi.com> <20030115060939.GB15975@redhat.com> <3E2570BD.2582F293@ieee.org> <20030115182850.GG15975@redhat.com> <3E25B762.B7C0452E@ieee.org> <20030115200607.GF23351@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030115200607.GF23351@redhat.com>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00055.txt.bz2

On Wed, Jan 15, 2003 at 03:06:07PM -0500, Christopher Faylor wrote:
>On Wed, Jan 15, 2003 at 02:32:50PM -0500, Pierre A. Humblet wrote:
>>Christopher Faylor wrote:
>>> 
>>> Ok.  Got it.  I checked in a patch.
>>> 
>>Chris,
>>
>>In a similar same vein, class fhandler_base has a member open_status
>>that is set in a dozen places but never read, AFAICT.
>
>Funny, I just noticed that a couple of weeks ago.  However, I am working
>on some code, which implements, which I anticipate will use it.
                               ^
                             fifos

cgf
