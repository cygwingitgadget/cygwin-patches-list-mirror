Return-Path: <cygwin-patches-return-4765-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30336 invoked by alias); 16 May 2004 02:57:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30326 invoked from network); 16 May 2004 02:57:51 -0000
Date: Sun, 16 May 2004 02:57:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: c:.
Message-ID: <20040516025750.GA24317@coe.bosbc.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040515223540.00810100@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040515223540.00810100@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q2/txt/msg00117.txt.bz2

On Sat, May 15, 2004 at 10:35:40PM -0400, Pierre A. Humblet wrote:
>I have run more tests and noticed that c:. and c:..
>are now interpreted as c:/
>That's because of the new code that strips trailing dots
>and spaces. 

Shouldn't it be interpreted as c:/?  Since c: is interpreted
as c:/, shouldn't c:/.. be interpreted as c:/?

cgf
