Return-Path: <cygwin-patches-return-3726-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5802 invoked by alias); 20 Mar 2003 01:34:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5790 invoked from network); 20 Mar 2003 01:34:29 -0000
Date: Thu, 20 Mar 2003 01:34:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] updated pthread list patch
Message-ID: <20030320013433.GB32580@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.WNT.4.44.0303191454490.257-200000@algeria.intern.net> <1048112562.5299.175.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048112562.5299.175.camel@localhost>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00375.txt.bz2

On Thu, Mar 20, 2003 at 09:22:42AM +1100, Robert Collins wrote:
>I'm happy with changing the method naming format, but is it GNU
>standard? Thats a requirement for the cygwin project.
>
>http://www.gnu.org/prep/standards_26.html#SEC26 says that 
>"For example, you should use names like ignore_space_change_flag; don't
>use names like iCantReadThis."
>
>Now, I happen to disagree with the GNU conventions here, particularly as
>they don't have a C++ section (and C doesn't have the same degree of
>name space conflicts that C++ does) :}. But, the pthread code should
>stay within the GNU guidelines.
>
>So, I'm sorry to have you jumping through hoops, but can you please
>change your patch so that all new methods use the GNU convention here.

Yes, again, I'd just like to be consistent in cygwin.  While there are
a few isFooBar type of things in the code, for the most part we don't
do things that way here.  I don't have a strong feeling either way but
I find it jarring to see things done one way in one section of the code
and another in other sections.  So, I change this kind of thing when I
stumble across it.

So, I agree with Robert.  Lets try to stick with the current way of
doing things since the majority of the code does things that way.
Also see my 1 == foo commentary earlier.

cgf
