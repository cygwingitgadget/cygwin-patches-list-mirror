Return-Path: <cygwin@jdrake.com>
Received: from mail231.csoft.net (mail231.csoft.net [96.47.74.235])
 by sourceware.org (Postfix) with ESMTPS id 930ED3854805
 for <cygwin-patches@cygwin.com>; Sat, 15 May 2021 19:17:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 930ED3854805
Received: from mail231.csoft.net (localhost [127.0.0.1])
 by mail231.csoft.net (Postfix) with ESMTP id 41F4DCB57
 for <cygwin-patches@cygwin.com>; Sat, 15 May 2021 15:17:49 -0400 (EDT)
Received: from persephone (c-76-121-15-23.hsd1.wa.comcast.net [76.121.15.23])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 (Authenticated sender: jeremyd)
 by mail231.csoft.net (Postfix) with ESMTPSA id 62989CB52
 for <cygwin-patches@cygwin.com>; Sat, 15 May 2021 15:17:48 -0400 (EDT)
Date: Sat, 15 May 2021 12:17:47 -0700 (Pacific Daylight Time)
From: Jeremy Drake <cygwin@jdrake.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Add support for high-entropy-va flag to peflags.
Message-ID: <alpine.WNT.2.22.394.2105151214260.7536@persephone>
User-Agent: Alpine 2.22 (WNT 394 2020-01-19)
X-X-Sender: jeremyd@mail231.csoft.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-12.3 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_LOW,
 SPF_HELO_PASS, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sat, 15 May 2021 19:17:51 -0000

This allows for setting, clearing, and displaying the value of the "high
entropy va" dll characteristics flag.

Signed-off-by: Jeremy Drake <github@jdrake.com>
---
I'm not sure this is the right list for this... I made this patch a while
back and it has been kicking around msys2's rebase package, figured I'd
submit it upstream.

 peflags.c | 130 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 69 insertions(+), 61 deletions(-)

diff --git a/peflags.c b/peflags.c
index 4d22e4a..358199a 100644
--- a/peflags.c
+++ b/peflags.c
@@ -112,7 +112,7 @@ static const symbolic_flags_t pe_symbolic_flags[] = {
 /*CF(0x0004, reserved_0x0004),*/
 /*CF(0x0008, reserved_0x0008),*/
 /*CF(0x0010, unspec_0x0010),*/
-/*CF(0x0020, unspec_0x0020),*/
+  CF(0x0020, high-entropy-va),
   CF(0x0040, dynamicbase),
   CF(0x0080, forceinteg),
   CF(0x0100, nxcompat),
@@ -180,30 +180,31 @@ sizeof_values_t sizeof_vals[5] = {
 #define pulong(struct, offset)		(PULONG)((PBYTE)(struct)+(offset))

 static struct option long_options[] = {
-  {"dynamicbase",  optional_argument, NULL, 'd'},
-  {"forceinteg",   optional_argument, NULL, 'f'},
-  {"nxcompat",     optional_argument, NULL, 'n'},
-  {"no-isolation", optional_argument, NULL, 'i'},
-  {"no-seh",       optional_argument, NULL, 's'},
-  {"no-bind",      optional_argument, NULL, 'b'},
-  {"wdmdriver",    optional_argument, NULL, 'W'},
-  {"tsaware",      optional_argument, NULL, 't'},
-  {"wstrim",       optional_argument, NULL, 'w'},
-  {"bigaddr",      optional_argument, NULL, 'l'},
-  {"sepdbg",       optional_argument, NULL, 'S'},
-  {"stack-reserve",optional_argument, NULL, 'x'},
-  {"stack-commit", optional_argument, NULL, 'X'},
-  {"heap-reserve", optional_argument, NULL, 'y'},
-  {"heap-commit",  optional_argument, NULL, 'Y'},
-  {"cygwin-heap",  optional_argument, NULL, 'z'},
-  {"filelist",     no_argument, NULL, 'T'},
-  {"verbose",      no_argument, NULL, 'v'},
-  {"help",         no_argument, NULL, 'h'},
-  {"version",      no_argument, NULL, 'V'},
+  {"dynamicbase",     optional_argument, NULL, 'd'},
+  {"high-entropy-va", optional_argument, NULL, 'e'},
+  {"forceinteg",      optional_argument, NULL, 'f'},
+  {"nxcompat",        optional_argument, NULL, 'n'},
+  {"no-isolation",    optional_argument, NULL, 'i'},
+  {"no-seh",          optional_argument, NULL, 's'},
+  {"no-bind",         optional_argument, NULL, 'b'},
+  {"wdmdriver",       optional_argument, NULL, 'W'},
+  {"tsaware",         optional_argument, NULL, 't'},
+  {"wstrim",          optional_argument, NULL, 'w'},
+  {"bigaddr",         optional_argument, NULL, 'l'},
+  {"sepdbg",          optional_argument, NULL, 'S'},
+  {"stack-reserve",   optional_argument, NULL, 'x'},
+  {"stack-commit",    optional_argument, NULL, 'X'},
+  {"heap-reserve",    optional_argument, NULL, 'y'},
+  {"heap-commit",     optional_argument, NULL, 'Y'},
+  {"cygwin-heap",     optional_argument, NULL, 'z'},
+  {"filelist",        no_argument, NULL, 'T'},
+  {"verbose",         no_argument, NULL, 'v'},
+  {"help",            no_argument, NULL, 'h'},
+  {"version",         no_argument, NULL, 'V'},
   {NULL, no_argument, NULL, 0}
 };
 static const char *short_options
-	= "d::f::n::i::s::b::W::t::w::l::S::x::X::y::Y::z::T:vhV";
+	= "d::e::f::n::i::s::b::W::t::w::l::S::x::X::y::Y::z::T:vhV";

 static void short_usage (FILE *f);
 static void help (FILE *f);
@@ -699,6 +700,11 @@ parse_args (int argc, char *argv[])
 	                         optarg,
 	                         IMAGE_DLLCHARACTERISTICS_DYNAMIC_BASE);
 	  break;
+	case 'e':
+	  handle_pe_flag_option (long_options[option_index].name,
+	                         optarg,
+	                         IMAGE_DLLCHARACTERISTICS_HIGH_ENTROPY_VA);
+	  break;
 	case 'n':
 	  handle_pe_flag_option (long_options[option_index].name,
 	                         optarg,
@@ -1067,45 +1073,47 @@ help (FILE *f)
 "given, the specified value will be overwritten; if no argument is given, the\n"
 "numerical value will be displayed in decimal and hexadecimal notation.\n"
 "\n"
-"  -d, --dynamicbase  [BOOL]   Image base address may be relocated using\n"
-"                              address space layout randomization (ASLR).\n"
-"  -f, --forceinteg   [BOOL]   Code integrity checks are enforced.\n"
-"  -n, --nxcompat     [BOOL]   Image is compatible with data execution\n"
-"                              prevention (DEP).\n"
-"  -i, --no-isolation [BOOL]   Image understands isolation but do not isolate\n"
-"                              the image.\n"
-"  -s, --no-seh       [BOOL]   Image does not use structured exception handling\n"
-"                              (SEH). No SE handler may be called in this image.\n"
-"  -b, --no-bind      [BOOL]   Do not bind this image.\n"
-"  -W, --wdmdriver    [BOOL]   Driver uses the WDM model.\n"
-"  -t, --tsaware      [BOOL]   Image is Terminal Server aware.\n"
-"  -w, --wstrim       [BOOL]   Aggressively trim the working set.\n"
-"  -l, --bigaddr      [BOOL]   The application can handle addresses larger\n"
-"                              than 2 GB.\n"
-"  -S, --sepdbg       [BOOL]   Debugging information was removed and stored\n"
-"                              separately in another file.\n"
-"  -x, --stack-reserve [NUM]   Reserved stack size of the process in bytes.\n"
-"  -X, --stack-commit  [NUM]   Initial commited portion of the process stack\n"
-"                              in bytes.\n"
-"  -y, --heap-reserve  [NUM]   Reserved heap size of the default application\n"
-"                              heap in bytes.  Note that this value has no\n"
-"                              significant meaning to Cygwin applications.\n"
-"                              See the -z, --cygwin-heap option instead.\n"
-"  -Y, --heap-commit   [NUM]   Initial commited portion of the default\n"
-"                              application heap in bytes.  Note that this value\n"
-"                              has no significant meaning to Cygwin applications.\n"
-"                              See the -z, --cygwin-heap option instead.\n"
-"  -z, --cygwin-heap   [NUM]   Initial reserved heap size of the Cygwin\n"
-"                              application heap in Megabytes.  This value is\n"
-"                              only evaluated starting with Cygwin 1.7.10.\n"
-"                              Useful values are between 4 and 2048.  If 0,\n"
-"                              Cygwin uses the default heap size of 384 Megs.\n"
-"                              Has no meaning for non-Cygwin applications.\n"
-"  -T, --filelist FILE         Indicate that FILE contains a list\n"
-"                              of PE files to process\n"
-"  -v, --verbose               Display diagnostic information\n"
-"  -V, --version               Display version information\n"
-"  -h, --help                  Display this help\n"
+"  -d, --dynamicbase     [BOOL] Image base address may be relocated using\n"
+"                               address space layout randomization (ASLR).\n"
+"  -e, --high-entropy-va [BOOL] Image is compatible with 64-bit address space\n"
+"                               layout randomization (ASLR).\n"
+"  -f, --forceinteg      [BOOL] Code integrity checks are enforced.\n"
+"  -n, --nxcompat        [BOOL] Image is compatible with data execution\n"
+"                               prevention (DEP).\n"
+"  -i, --no-isolation    [BOOL] Image understands isolation but do not isolate\n"
+"                               the image.\n"
+"  -s, --no-seh          [BOOL] Image does not use structured exception handling\n"
+"                               (SEH). No SE handler may be called in this image.\n"
+"  -b, --no-bind         [BOOL] Do not bind this image.\n"
+"  -W, --wdmdriver       [BOOL] Driver uses the WDM model.\n"
+"  -t, --tsaware         [BOOL] Image is Terminal Server aware.\n"
+"  -w, --wstrim          [BOOL] Aggressively trim the working set.\n"
+"  -l, --bigaddr         [BOOL] The application can handle addresses larger\n"
+"                               than 2 GB.\n"
+"  -S, --sepdbg          [BOOL] Debugging information was removed and stored\n"
+"                               separately in another file.\n"
+"  -x, --stack-reserve    [NUM] Reserved stack size of the process in bytes.\n"
+"  -X, --stack-commit     [NUM] Initial commited portion of the process stack\n"
+"                               in bytes.\n"
+"  -y, --heap-reserve     [NUM] Reserved heap size of the default application\n"
+"                               heap in bytes.  Note that this value has no\n"
+"                               significant meaning to Cygwin applications.\n"
+"                               See the -z, --cygwin-heap option instead.\n"
+"  -Y, --heap-commit      [NUM] Initial commited portion of the default\n"
+"                               application heap in bytes.  Note that this value\n"
+"                               has no significant meaning to Cygwin applications\n"
+"                               See the -z, --cygwin-heap option instead.\n"
+"  -z, --cygwin-heap      [NUM] Initial reserved heap size of the Cygwin\n"
+"                               application heap in Megabytes.  This value is\n"
+"                               only evaluated starting with Cygwin 1.7.10.\n"
+"                               Useful values are between 4 and 2048.  If 0,\n"
+"                               Cygwin uses the default heap size of 384 Megs.\n"
+"                               Has no meaning for non-Cygwin applications.\n"
+"  -T, --filelist FILE          Indicate that FILE contains a list\n"
+"                               of PE files to process\n"
+"  -v, --verbose                Display diagnostic information\n"
+"  -V, --version                Display version information\n"
+"  -h, --help                   Display this help\n"
 "\n"
 "BOOL: may be 1, true, or yes - indicates that the flag should be set\n"
 "          if 0, false, or no - indicates that the flag should be cleared\n"
-- 
2.31.1.windows.1

