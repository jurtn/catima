import ReactOnRails from 'react-on-rails';

import DateTimeInput from '../bundles/DateTimeInput/components/DateTimeInput';

import GeoEditor from '../bundles/GeoEditor/components/GeoEditor';

import StyleControl from '../bundles/StyleControl/components/StyleControl';
import FontColorButton from '../bundles/StyleControl/components/FontColorButton';
import FontExample from '../bundles/StyleControl/components/FontExample';
import FontMenu from '../bundles/StyleControl/components/FontMenu';
import FontSize from '../bundles/StyleControl/components/FontSize';
import FontStyle from '../bundles/StyleControl/components/FontStyle';

import TemplateEditor from '../bundles/TemplateEditor/components/TemplateEditor';

import ThumbnailControl from '../bundles/ThumbnailControl/components/ThumbnailControl';

import TranslatedTextField from '../bundles/TranslatedTextField/components/TranslatedTextField';


ReactOnRails.register({
  DateTimeInput,
  GeoEditor,
  StyleControl, FontColorButton, FontExample, FontMenu, FontSize, FontStyle,
  TemplateEditor,
  ThumbnailControl,
  TranslatedTextField,
});