Return-Path: <cygwin-patches-return-3728-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29041 invoked by alias); 20 Mar 2003 07:51:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29028 invoked from network); 20 Mar 2003 07:51:04 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Thu, 20 Mar 2003 07:51:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: Robert Collins <rbcollins@cygwin.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] updated pthread list patch
In-Reply-To: <1048112562.5299.175.camel@localhost>
Message-ID: <Pine.WNT.4.44.0303200839380.232-100000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q1/txt/msg00377.txt.bz2



On Wed, 19 Mar 2003, Robert Collins wrote:

> I'm happy with changing the method naming format, but is it GNU
> standard? Thats a requirement for the cygwin project.
>
> http://www.gnu.org/prep/standards_26.html#SEC26 says that
> "For example, you should use names like ignore_space_change_flag; don't
> use names like iCantReadThis."
>
> Now, I happen to disagree with the GNU conventions here, particularly as
> they don't have a C++ section (and C doesn't have the same degree of
> name space conflicts that C++ does) :}. But, the pthread code should
> stay within the GNU guidelines.
>
> So, I'm sorry to have you jumping through hoops, but can you please
> change your patch so that all new methods use the GNU convention here.
>

I just followed the already existing method names in thread.h. Methods
like forEach, initMutex or isGoodObject were made by you.

I would suggest to commit my patch now and do a method renaming and
1==foo to foo==1 cleanup in a second step.

Thomas
