Return-Path: <cygwin-patches-return-5265-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20289 invoked by alias); 20 Dec 2004 17:18:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20263 invoked from network); 20 Dec 2004 17:18:43 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 20 Dec 2004 17:18:43 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id D2DD21B4C2; Mon, 20 Dec 2004 12:20:04 -0500 (EST)
Date: Mon, 20 Dec 2004 17:18:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch to allow trailing dots on managed mounts
Message-ID: <20041220172004.GB5827@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20041216160322.GC16474@cygbert.vinschen.de> <3.0.5.32.20041216220441.0082a400@incoming.verizon.net> <3.0.5.32.20041219215720.0082da20@incoming.verizon.net> <20041220102329.GL9277@cygbert.vinschen.de> <20041220151716.GA1175@trixie.casa.cgf.cx> <41C6F57E.2D058229@phumblet.no-ip.org> <20041220161216.GH1175@trixie.casa.cgf.cx> <41C6FB3D.D9990C3F@phumblet.no-ip.org> <20041220163218.GJ1175@trixie.casa.cgf.cx> <41C7032C.A8C9DD37@phumblet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C7032C.A8C9DD37@phumblet.no-ip.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00266.txt.bz2

On Mon, Dec 20, 2004 at 11:51:56AM -0500, Pierre A. Humblet wrote:
>
>Christopher Faylor wrote:
>> 
>> On Mon, Dec 20, 2004 at 11:18:05AM -0500, Pierre A. Humblet wrote:
>> >
>> >Christopher Faylor wrote:
>> >>
>> >> On Mon, Dec 20, 2004 at 10:53:34AM -0500, Pierre A. Humblet wrote:
>> >> >Stripping from the Posix path can't be done during normalize_
>> >> >because it would apply to all paths (not only disk).
>> >>
>> >> Why can't we just strip the dots from the path in
>> >> path_conv::set_normalized path?
>> >
>> >You can, after checking the device. But why do it all
>> >the time if it's only needed by chdir?
>> 
>> It just seems more consistent and safer to do the same thing to both the
>> win32 and posix paths.  chroot probably needs it too.  After removing
>> the code from normalize_posix_path, this is probably not a performance
>> hit.
>
>Good points. normalize_posix_path already finds the length, so the
>performance hit will be really small.
>
>Not sure what you mean by "removing the code from normalize_posix_path".
>It's still important that normalize_{posix,win32}_path strip the final 
>'.' in "xxxx/.", because :check looks for a final /

I meant remove the code that I sent here and which I just removed after
Corinna's response.

cgf
