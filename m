Return-Path: <cygwin-patches-return-3691-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25316 invoked by alias); 11 Mar 2003 20:44:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25307 invoked from network); 11 Mar 2003 20:44:31 -0000
Date: Tue, 11 Mar 2003 20:44:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: fhandler_socket::dup
Message-ID: <20030311204438.GA9700@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030310200902.007f3100@mail.attbi.com> <20030311102431.GB13544@cygbert.vinschen.de> <3E6DF617.CA7DC2C0@ieee.org> <20030311152028.GF13544@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030311152028.GF13544@cygbert.vinschen.de>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00340.txt.bz2

On Tue, Mar 11, 2003 at 04:20:28PM +0100, Corinna Vinschen wrote:
>On Tue, Mar 11, 2003 at 09:43:35AM -0500, Pierre A. Humblet wrote:
>> Corinna Vinschen wrote:
>> >
>> > I'm seriously concidering to remove all the fixup_before/fixup_after
>> > from fhandler_socket::dup() and just call fhandler_base::dup() on
>> > NT systems.
>>  
>> Corinna,
>> 
>> Isn't that just what you do now?
>
>I created the patch after sending the mail.

Should I put this in 1.3.21?  It's not too late.

cgf
