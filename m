Return-Path: <cygwin-patches-return-2153-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7324 invoked by alias); 4 May 2002 18:27:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7298 invoked from network); 4 May 2002 18:27:55 -0000
Date: Sat, 04 May 2002 11:27:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Bug in ln / cygwin1.dll
Message-ID: <20020504182803.GA29885@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <011901c1f2fb$1fbf5330$0100a8c0@advent02> <20020504042742.GI32261@redhat.com> <00c801c1f36d$73d55470$0100a8c0@advent02> <20020504153612.GC29229@redhat.com> <016001c1f383$90e0c700$0100a8c0@advent02>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <016001c1f383$90e0c700$0100a8c0@advent02>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00137.txt.bz2

On Sat, May 04, 2002 at 04:51:33PM +0100, Chris January wrote:
>> >This patch fixes the problem.
>>
>> Why?
>In the destructor, the code checks if normalized_path is non-NULL before
>callin cfree on it.

Thanks for the explanation.  Committed.

cgf
