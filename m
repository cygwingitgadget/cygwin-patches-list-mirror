Return-Path: <cygwin-patches-return-4385-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6917 invoked by alias); 14 Nov 2003 19:10:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6908 invoked from network); 14 Nov 2003 19:10:13 -0000
Date: Fri, 14 Nov 2003 19:10:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: thunking, the next step
Message-ID: <20031114191010.GA22870@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3FB4C443.2040301@cygwin.com> <20031114155716.GA16485@redhat.com> <1068832363.1109.101.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1068832363.1109.101.camel@localhost>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00104.txt.bz2

On Sat, Nov 15, 2003 at 04:52:43AM +1100, Robert Collins wrote:
>On Sat, 2003-11-15 at 02:57, Christopher Faylor wrote:
>> On Fri, Nov 14, 2003 at 11:02:11PM +1100, Robert Collins wrote:
>> >Ok, I've now integrated and generalised Ron's unicode support mini-patch.
>> >
>> >So, here tis a version that, well the changelog explains the overview, 
>> >and io.h the detail.
>> >
>> >Overhead wise, this is reasonably low:
>> >1 strlen() per IO call minimum.
>> >1 unicode conversion, only if needed.
>> 
>> And a couple of tests for "do we do unicode" for every call.
>
>Which are all inline aren't they? I guess I don't see the overhead as
>significant compared to the strlen generation.

I'd rather just make the decision at initialization time if we can.
Possibly we could extend the function loader to either call FooW or
FooA as appropriate when Foo is specified.

cgf
