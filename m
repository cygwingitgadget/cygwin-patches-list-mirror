Return-Path: <cygwin-patches-return-4381-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14691 invoked by alias); 14 Nov 2003 15:57:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14680 invoked from network); 14 Nov 2003 15:57:20 -0000
Date: Fri, 14 Nov 2003 15:57:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: thunking, the next step
Message-ID: <20031114155716.GA16485@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3FB4C443.2040301@cygwin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FB4C443.2040301@cygwin.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00100.txt.bz2

On Fri, Nov 14, 2003 at 11:02:11PM +1100, Robert Collins wrote:
>Ok, I've now integrated and generalised Ron's unicode support mini-patch.
>
>So, here tis a version that, well the changelog explains the overview, 
>and io.h the detail.
>
>Overhead wise, this is reasonably low:
>1 strlen() per IO call minimum.
>1 unicode conversion, only if needed.

And a couple of tests for "do we do unicode" for every call.

I wonder if path_conv couldn't be doing more of the upfront work.

cgf

>inlined code, so no additional function calls.
