Return-Path: <cygwin-patches-return-2917-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 3118 invoked by alias); 2 Sep 2002 16:33:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3100 invoked from network); 2 Sep 2002 16:33:51 -0000
Date: Mon, 02 Sep 2002 09:33:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: very small passwd patch
Message-ID: <20020902163355.GD16203@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.44.0209021109360.1260-100000@joshua.iocc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.44.0209021109360.1260-100000@joshua.iocc.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00365.txt.bz2

On Mon, Sep 02, 2002 at 11:09:54AM -0500, Joshua Daniel Franklin wrote:
>--- Corinna Vinschen <cygwin-patches@cygwin.com> wrote:
>> On Mon, Sep 02, 2002 at 08:28:07AM -0500, Joshua Daniel Franklin wrote:
>> > I thought there was some mention of this already, but I guess
>> > not. This adds a note about passwd not working with Win9x/ME.
>>
>> Good idea but it doesn't help.  Since passwd is linked statically
>> against a symbol only available in NT, a 9x/Me user will never see
>> this help.  The system dialog will always win the race.
>>
>
>True, but it would at least help with people who use NT on another machine
>diagnose the problem. Right now it's completely hidden.
>Also the --help notes are eventually folded into the User's Guide.

How about a patch to dynamically load the specific function so that the
error message will work correctly?

cgf
