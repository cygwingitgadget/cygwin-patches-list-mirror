Return-Path: <cygwin-patches-return-5246-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10793 invoked by alias); 18 Dec 2004 18:29:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10614 invoked from network); 18 Dec 2004 18:29:18 -0000
Received: from unknown (HELO smartmx-03.inode.at) (213.229.60.35)
  by sourceware.org with SMTP; 18 Dec 2004 18:29:18 -0000
Received: from [62.99.252.218] (port=64578 helo=[192.168.0.2])
	by smartmx-03.inode.at with esmtp (Exim 4.34)
	id 1CfjKP-00052v-8y
	for cygwin-patches@cygwin.com; Sat, 18 Dec 2004 19:29:17 +0100
Message-ID: <41C476F1.6060700@x-ray.at>
Date: Sat, 18 Dec 2004 18:29:00 -0000
From: Reini Urban <rurban@x-ray.at>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8a4) Gecko/20040927
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: Patch to allow trailing dots on managed mounts
References: <20041216155707.GG23488@trixie.casa.cgf.cx> <20041216160322.GC16474@cygbert.vinschen.de> <3.0.5.32.20041216220441.0082a400@incoming.verizon.net> <20041217032627.GF26712@trixie.casa.cgf.cx> <3.0.5.32.20041216224347.0082d210@incoming.verizon.net> <20041217061741.GG26712@trixie.casa.cgf.cx> <41C31496.4D9140C7@phumblet.no-ip.org> <20041217175649.GA1237@trixie.casa.cgf.cx> <41C36530.89F5A621@phumblet.no-ip.org> <20041218003615.GB3068@trixie.casa.cgf.cx> <20041218172053.GA9932@trixie.casa.cgf.cx>
In-Reply-To: <20041218172053.GA9932@trixie.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q4/txt/msg00247.txt.bz2

Christopher Faylor schrieb:
> On Fri, Dec 17, 2004 at 07:36:15PM -0500, Christopher Faylor wrote:
> 
>>If /cygdrive/c/cygwin/bin./ls.exe works, then /bin./ls.exe should also work.
>>Or, both should fail.  "consistent"
> 
> 
> Thinking some more about this, there are really some inconsistencies with
> the current and proposed behavior that I don't like.
> 
> Here's a table.  Please let me know if I got anything wrong:
> 
> What			   Now	       Pierre's proposal   Windows Equiv
> ls /bin...		   Works       Won't work	   dir c:\cygwin\bin... doesn't work
> ls /bin.		   Works       Won't work(?)	   dir c:\cygwin\bin. works
> ls /lib/gcc.		   Works       Works(?)		   dir c:\cygwin\lib\gcc. works
> ls /lib./gcc.		   Works       Won't work(?)	   dir c:\cygwin\lib.\gcc. works
> ls /cygdrive/c/cygwin/bin. Works       Works(?)		   dir c:\cygwin\bin. works
> ls /bin../ls.exe	   Won't work  Won't work	   dir c:\cygwin\bin..\ls.exe won't work
> ls /cygdrive/c/cygwin/bin../ls.exe
>                            Won't work  Won't work          ditto
> ls /bin/ls.exe...          Works       Works(?)            dir c:\cygwin\bin\ls.exe... works
> ln -s foo bar.		   "Works"*    Works**             .lnk files with dot extensions allowed
> 
> If I understand this correctly, I think "Pierre's proposal" == "cygwin's
> behavior before 2004/4", on all counts.
> 
> So, in thinking about all of this, I have a radical proposal which I
> have previously alluded to.
> 
> path_conv::check could detect the existence of trailing dots or spaces
> in path components of the output win32 path and set ENOENT in such cases
> unless the file was associated with either a managed mount or Corinna's
> proposed "posix" mount.
> 
> The rationale for this is that you really can't (except in the symlink
> case) create a file with a trailing dot so why should we lie and say
> that you can?
> 
> This probably is too radical an idea and would result in breakage.  So,
> my alternate thought is that single dots should be silently ignored in
> all path components.  Multiple dots should be ignored in the trailing
> path component, regardless of whether the file refers to a directory or
> not, which makes cygwin slightly incompatible with windows.
> 
> I'm not sure how spaces fall out in the above table.  I'm not sure that the
> same rules should be applied for spaces and dots above.

I have no strong opinion in these issues (yet), but please look also at 
the related ending-colon ':extension' problem on NTFS.
Such files are also not listed, but probably should be.

"listing ADS streams" http://cygwin.com/ml/cygwin/2004-11/msg00292.html
-- 
Reini Urban
http://xarch.tu-graz.ac.at/home/rurban/
