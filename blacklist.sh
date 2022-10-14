#!/bin/bash

# Find places in files, where circleCrop(), oval shapes or ugly colours are used
grep -FRHn -f <(cat <<"EOF"
0099cc
1851b4
1d85d7
2c6bed
3a76f0
42A5F5
5151F6
6191f3
8B8BF9
blue_400
circleCrop
core_blue
conversation_blue
EOF
) | # Accept a few expections; of course, don't search .git and this file
grep -Ev -f <(cat <<"EOF"
^\.git/
^app/src/main/baseline-prof.txt
^app/src/main/java/org/thoughtcrime/securesms/avatar/fallback/FallbackAvatarDrawable.kt:37
^app/src/main/java/org/thoughtcrime/securesms/color/MaterialColor.java:25
^app/src/main/java/org/thoughtcrime/securesms/conversation/colors/ChatColorsPalette.kt:204
^app/src/main/java/org/thoughtcrime/securesms/insights/InsightsUserAvatar\.java:35
^app/src/main/java/org/thoughtcrime/securesms/mediasend/v2/text/TextStoryBackgroundColors.kt:66
^app/src/main/java/org/thoughtcrime/securesms/mediasend/v2/text/TextStoryBackgroundColors.kt:70
^app/src/main/res/values/conversation_colors.xml:27
^app/src/main/res/values/conversation_colors.xml:28
^app/src/main/res/values/conversation_colors.xml:29
^app/src/main/res/values/material_colors.xml:24
^blacklist\.sh:
EOF
)
