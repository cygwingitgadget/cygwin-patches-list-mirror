Return-Path: <cygwin-patches-return-5390-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28461 invoked by alias); 28 Mar 2005 17:04:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28001 invoked from network); 28 Mar 2005 17:04:16 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 28 Mar 2005 17:04:16 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 7171713C84F; Mon, 28 Mar 2005 12:04:16 -0500 (EST)
Date: Mon, 28 Mar 2005 17:04:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: exceeding PATH_MAX
Message-ID: <20050328170416.GB20104@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4245843E.10700@byu.net> <20050326164106.GB11382@trixie.casa.cgf.cx> <loom.20050328T175951-73@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <loom.20050328T175951-73@post.gmane.org>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q1/txt/msg00093.txt.bz2

On Mon, Mar 28, 2005 at 04:19:08PM +0000, Eric Blake wrote:
>Christopher Faylor <cgf-no-personal-reply-please <at> cygwin.com> writes:
>> >2005-03-26  Eric Blake  <ebb9 <at> byu.net>
>> >
>> >	* errno.cc (FILENAME_EXCED_RANGE): Map to ENAMETOOLONG.
>> 
>> This is apparently fixing the symptom rather than the problem.  Cygwin
>> is supposed to be detecting if the name is too long before it gets to
>> the windows api.
>
>Well, cygwin did not detect it, as proved by this portion of the strace from 
>the test program I attached:

That would be "the symptom".

>I don't see any reason why this mapping should not be applied, even if you also 
>patch mkdir to error out early rather than calling CreateDirectory.

I've checked in the errno patch.

Thanks.

cgf
