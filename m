Return-Path: <cygwin-patches-return-3875-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10656 invoked by alias); 22 May 2003 19:07:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10647 invoked from network); 22 May 2003 19:07:34 -0000
Date: Thu, 22 May 2003 19:07:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch for line draw characters problem & screen scrolling
Message-ID: <20030522190722.GB4621@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <BAY1-DAV24HHGNZ4mF100020af2@hotmail.com> <20030521162232.GC3096@redhat.com> <s1sof1vzgj1.fsf@jaist.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s1sof1vzgj1.fsf@jaist.ac.jp>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00102.txt.bz2

On Thu, May 22, 2003 at 02:39:30PM +0900, Kazuhiro Fujieda wrote:
>>>> On Wed, 21 May 2003 12:22:32 -0400
>>>> Christopher Faylor <cgf@redhat.com> said:
>
>> >* fhandler_console.cc (write_normal): cancelled premature optimization, do
>> >always use scroll_screen instead of '\n' sometimes
>> 
>> No.  This section of code has been hacked back and forth for years.  This
>> one is not going to happen.
>
>As an additional explanation, this optimization makes the
>scrolling down accelerate considerably (2-3 times faster)
>on Win9x/Me.

Thanks.  I knew we had a good reason for this but I forgot what
it was.

cgf
