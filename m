From: Mark Paulus <mark.paulus@wcom.com>
To: Cygwin Patches <cygwin-patches@sources.redhat.com>
Subject: Re: [PATCH] syscalls.cc for statfs/df under Win9x problem
Date: Tue, 13 Mar 2001 08:12:00 -0000
Message-id: <0GA5006AG8XLMZ@dgismtp03.wcomnet.com>
References: <20010313155155.C569@cygbert.vinschen.de>
X-SW-Source: 2001-q1/msg00182.html

Yes, I did try it with UNCs, and it works fine.  I was having a 
problem with the GetDiskFreeSpace() working correctly
with UNC's, but GetDiskFreeSpaceEx() works great.
Unfortunately, I can't test all possible combinations...  My
test environments consist of a Lan with Athlon/WinME, 
AMD K6-3+/WinME and AMD K6-3+/Debian 2.2 / SMB.
My other environment is a Lan with Intel P-II/Win2K,
P-II / OS/2, and lots of different NT/OS/2 boxes, and a
Novell server.  But I don't have any WinMe/NT Combinations.

I will follow up on the rights assignment document.  I guess that
will put this on hold for now...

And I will fix the formatting issues when I re-submit the patch,
after I get the assignment taken care of.



On Tue, 13 Mar 2001 15:51:55 +0100, Corinna Vinschen wrote:

>
>Chris, is that patch small enough to go in without copyright assignment?
>
>On Mon, Mar 12, 2001 at 02:43:03PM -0700, Mark Paulus wrote:
>> Enclosed is a patch to fix the 2GB limit problem under Win9x
>> exhibited by df.  The only problem I can see is a failure with
>> repeated calls to a SMB share under WinME.  The first call to 
>> statfs() gets good values, but the 2nd call returns some bogus 
>> values.  I do not have access to a SMB share under Win2K 
>> to see if it fails there also.  
>
>Mark,
>
>I asked this already once you've send your first version. Did you
>try your patch with UNC paths? I'm asking because MSDN states
>that UNC paths must end with a backslash when using this function
>(\\server\share\). It would be really nice if you could have a look.
>
>And two nags:
>
>- Please remove the cvsId patch. We don't use it anywhere in the
>  sources.
>
>- Could you please rearrange your patch so that it's according
>  to the GNU coding standard ( http://www.gnu.org/prep/standards_toc.html )
>
>  For example, not so:  func( param ), func(param)
>  but so:		func (param)
>
>  and not so:		if () {
>  			  body
>  			} else {
>			}
>  or			if ()
>  			{
>			  body
>			}
>			else
>			{
>			}
>  but so:		if ()
>  			  {
>			    body
>			  }
>			else
>			  {
>			  }
>
>Thanks,
>Corinna
>
>-- 
>Corinna Vinschen                  Please, send mails regarding Cygwin to
>Cygwin Developer                                mailto:cygwin@cygwin.com
>Red Hat, Inc.


