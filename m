Return-Path: <cygwin-patches-return-3587-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16750 invoked by alias); 18 Feb 2003 22:21:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16733 invoked from network); 18 Feb 2003 22:21:27 -0000
Message-ID: <000701c2d79c$140f9230$78d96f83@pomello>
From: "Max Bowsher" <maxb@ukf.net>
To: <cygwin-patches@cygwin.com>
References: <20030218221239.U46120-100000@logout.sh.cvut.cz> <009c01c2d79a$552579d0$78d96f83@pomello> <20030218221257.GA2458@redhat.com>
Subject: Re: Create new files as sparse on NT systems. (2nd try)
Date: Tue, 18 Feb 2003 22:21:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-SW-Source: 2003-q1/txt/msg00236.txt.bz2

Christopher Faylor wrote:
> On Tue, Feb 18, 2003 at 10:08:56PM -0000, Max Bowsher wrote:
>> Two things - First:
>>
>> Please, please don't make this the default! Once a file is
>> sparsified, it cannot be unsparsified except by copying the contents
>> to a new file! This seems like an optimization for a corner case is
>> trying to cause a global change.
>
> Why is it a big deal if a file is sparse?  I don't get it.  In 99% of
> the cases this won't be a big deal.  In the cases where it is a big
> deal, cygwin will be operating more like UNIX.

Mainly, it feels aesthetically horrible to me.

And, we don't have any benchmarks for the common case, yet.

What kind of program would actually benefit from sparse files? And shouldn't
it be the responsibility of that program to request them?


>> And:
>>
>> FSCTL_SET_SPARSE, used in the patch, is *not defined* in current
>> w32api !!!
>
> Calm down:
>
> 2003-02-17 Vaclav Haisman <V.Haisman@sh.cvut.cz>
>
>         * include/winioctl.h (FSCTL_SET_SPARSE): Define.

Oops.



Max.
