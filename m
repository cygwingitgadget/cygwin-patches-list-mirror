Return-Path: <cygwin-patches-return-3338-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12129 invoked by alias); 16 Dec 2002 22:45:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12102 invoked from network); 16 Dec 2002 22:45:53 -0000
Date: Mon, 16 Dec 2002 14:45:00 -0000
From: Steve O <bub@io.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] to_slave pipe is full fix
Message-ID: <20021216164704.A13198@fnord.io.com>
References: <20021215144314.A28430@eris.io.com> <20021216170122.G19104@cygbert.vinschen.de> <20021216131554.D30600@hagbard.io.com> <20021216193629.GB19567@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021216193629.GB19567@redhat.com>; from cgf@redhat.com on Mon, Dec 16, 2002 at 02:36:29PM -0500
X-SW-Source: 2002-q4/txt/msg00289.txt.bz2

On Mon, Dec 16, 2002 at 02:36:29PM -0500, Christopher Faylor wrote:
> On Mon, Dec 16, 2002 at 01:15:54PM -0600, Steve O wrote:
> -             SetEvent (input_available_event);
> -             ReleaseMutex (input_mutex);
> -             Sleep (10);
> -             rc = WaitForSingleObject (input_mutex, INFINITE);
> +             puts_readahead (p, bytes_left);
> +             ret = 0;
> +             break;
> 
> Won't this introduce a spinning situation since you are no longer
> sleeping?  

The 'break;' should pop us out of the loop.  Did I miss a control
structure?  The idea of the patch at least, was to bail out of a write
if the pipe is full.  

> Were we really inappropriately waiting for the input_mutex in
> this case?

For the case where the application expects the write to not block,
it seems inappropriate to wait.  For the case where the application
does a blocking write, the WriteFile should do the blocking and, unless
there is a problem, write all the bytes.

In fact, looking at it some more, the accept_input while loop is 
superfluous.  Sorry I missed that.  

-steve
