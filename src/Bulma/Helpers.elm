
module Bulma.Helpers exposing ( Helpers
                              , defaultHelpers
                              , node
                              )

-- IMPORTS ---------------------------------------------------------------------

import List exposing ( map, filter, singleton )
import Tuple exposing ( first, second )
import String exposing ( join )

import Html exposing ( Html, Attribute )
import Html.Attributes exposing ( class )


-- NODE ------------------------------------------------------------------------

node : Helpers -> String -> List String -> List (Attribute msg) -> List (Html msg) -> Html msg
node helps tag classes attrs
  = Html.node tag
  <| flip (::) attrs
  <| class
  <| join " "
  <| (++) classes
  <| helperClasses helps

-- HELPERS ---------------------------------------------------------------------

type Float = FloatLeft
           | FloatRight

type Device = Mobile
            | Tablet
            | Desktop
            | Widescreen

type TextAlign = TextLeft
               | TextCentered
               | TextRight

type alias Devices a = { mobile     : a
                       , tablet     : a
                       , desktop    : a
                       , widescreen : a
                       }

type Display = Block       
             | Flex       
             | Hidden
             | Inline    
             | InlineBlock
             | InlineFlex

type alias Helpers = { float        : Maybe Float
                     , textAlign    : Maybe TextAlign
                     , overlay      : Bool
                     , fullWidth    : Bool
                     , clearfix     : Bool
                     , marginless   : Bool
                     , paddingless  : Bool
                     , unselectable : Bool
                     , display      : Devices (Maybe Display)
                     }

defaultHelpers : Helpers
defaultHelpers = { float        = Nothing
                 , textAlign    = Nothing
                 , overlay      = False
                 , fullWidth    = False
                 , clearfix     = False
                 , marginless   = False
                 , paddingless  = False
                 , unselectable = False
                 , display      = { mobile     = Nothing
                                  , tablet     = Nothing
                                  , desktop    = Nothing
                                  , widescreen = Nothing
                                  }
                 }

(=>) : a -> b -> ( a, b )
(=>) = (,)

helperClasses : Helpers -> List String
helperClasses {float,textAlign,overlay,fullWidth,clearfix,marginless,paddingless,unselectable,display}
  = map first
  <| filter (second)
  <| [ "is-overlay"      => overlay
    , "is-clearfix"     => clearfix
    , "is-fullwidth"    => fullWidth
    , "is-marginless"   => marginless
    , "is-paddingless"  => paddingless
    , "is-unselectable" => unselectable
    , case float of
        Nothing         -> ""                => False
        Just FloatLeft  -> "is-pulled-left"  => True
        Just FloatRight -> "is-pulled-right" => True
    , case textAlign of
        Just TextCentered -> "has-text-centered" => True
        Just TextRight    -> "has-text-right"    => True
        Just TextLeft     -> "has-text-left"     => True
        Nothing           -> ""                  => False
    , case display.mobile of
        Just Flex        ->         "is-flex-mobile" => True
        Just Block       ->        "is-block-mobile" => True
        Just Hidden      ->       "is-hidden-mobile" => True 
        Just Inline      ->       "is-inline-mobile" => True
        Just InlineFlex  ->  "is-inline-flex-mobile" => True
        Just InlineBlock -> "is-inline-block-mobile" => True
        Nothing          -> ""                       => False
    , case display.tablet of
        Just Flex        ->         "is-flex-tablet-only" => True
        Just Block       ->        "is-block-tablet-only" => True
        Just Hidden      ->       "is-hidden-tablet-only" => True 
        Just Inline      ->       "is-inline-tablet-only" => True
        Just InlineFlex  ->  "is-inline-flex-tablet-only" => True
        Just InlineBlock -> "is-inline-block-tablet-only" => True
        Nothing          -> ""                            => False
    , case display.desktop of
        Just Flex        ->         "is-flex-desktop-only" => True
        Just Block       ->        "is-block-desktop-only" => True
        Just Hidden      ->       "is-hidden-desktop-only" => True 
        Just Inline      ->       "is-inline-desktop-only" => True
        Just InlineFlex  ->  "is-inline-flex-desktop-only" => True
        Just InlineBlock -> "is-inline-block-desktop-only" => True
        Nothing          -> ""                             => False
    , case display.widescreen of
        Just Flex        ->         "is-flex-widescreen-only" => True
        Just Block       ->        "is-block-widescreen-only" => True
        Just Hidden      ->       "is-hidden-widescreen-only" => True 
        Just Inline      ->       "is-inline-widescreen-only" => True
        Just InlineFlex  ->  "is-inline-flex-widescreen-only" => True
        Just InlineBlock -> "is-inline-block-widescreen-only" => True
        Nothing          -> ""                                => False
    ]
